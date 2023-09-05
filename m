Return-Path: <netdev+bounces-32047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB6792210
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789881C20959
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26FBCA6D;
	Tue,  5 Sep 2023 11:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C44CA49
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:11:15 +0000 (UTC)
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A1D1AE
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 04:11:13 -0700 (PDT)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([112.97.61.198])
	by sina.com (172.16.97.32) with ESMTP
	id 64F70CCC00007925; Tue, 5 Sep 2023 19:11:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 30399712845710
X-SMAIL-UIID: B0F9B5E4945E436C9D7FF5E9B6A30FC5-20230905-191111
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Netdev <netdev@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request at virtual address
Date: Tue,  5 Sep 2023 19:10:59 +0800
Message-Id: <20230905111059.5618-1-hdanton@sina.com>
In-Reply-To: <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp> <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com> <20230903005334.5356-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.com>
> On Sun, Sep 3, 2023 at 5:57=E2=80=AFAM Hillf Danton <hdanton@sina.com>
> > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@google.com>
> > > --- a/net/core/dst.c
> > > +++ b/net/core/dst.c
> > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > >
> > >  void dst_release(struct dst_entry *dst)
> > >  {
> > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > +                       dst->flags |= DST_NOCOUNT;
> > > +                       dst_entries_add(dst->ops, -1);
> >
> > Could this add happen after the rcu sync above?
> >
> I do not think so. All dst_release() should happen before netns removal.

	cpu2                    cpu3
	====                    ====
	cleanup_net()           __sys_sendto
	                        sock_sendmsg()
	                        udpv6_sendmsg()
	synchronize_rcu();
				dst_release()

Could this one be an exception?

