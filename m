Return-Path: <netdev+bounces-28034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A077E110
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545522819AD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531310798;
	Wed, 16 Aug 2023 12:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B76101C8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:05:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2D212E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692187545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQx4IFcBhSy09p6OmuMqdz/jXmjpr3jWunNw/j5/AEM=;
	b=Qnmh6hOu9LYpcpNBJfGlGLva/v/fCRUbcV7bYqhGM7O1J/NIheIklHlag1dVADOpWA51oc
	lDCF8/Iup2w3h57nk4JZkgBUBb0oXf10BVzpdMlAriKKG6rjqNBwS6MnY1DT7abZK0mWfo
	avTO0NcCka56VLvFgaNdcfN4rmpyhsU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-GTYy9SS7MEWypOFY5y-zug-1; Wed, 16 Aug 2023 08:05:42 -0400
X-MC-Unique: GTYy9SS7MEWypOFY5y-zug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F74C1C06ED5;
	Wed, 16 Aug 2023 12:05:42 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.9.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B2EFC1121314;
	Wed, 16 Aug 2023 12:05:41 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  andrey.zhadchenko@virtuozzo.com,
  dev@openvswitch.org,  brauner@kernel.org,  netdev@vger.kernel.org,
  edumazet@google.com,  pabeni@redhat.com,
  syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: reject negative ifindex
References: <20230814203840.2908710-1-kuba@kernel.org>
	<f7t1qg4zddd.fsf@redhat.com> <20230815191809.2d18c9f5@kernel.org>
Date: Wed, 16 Aug 2023 08:05:41 -0400
In-Reply-To: <20230815191809.2d18c9f5@kernel.org> (Jakub Kicinski's message of
	"Tue, 15 Aug 2023 19:18:09 -0700")
Message-ID: <f7tsf8jxkdm.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 15 Aug 2023 08:41:50 -0400 Aaron Conole wrote:
>> > Validate the inputes. Now the second command correctly returns:  
>> 
>> s/inputes/inputs/
>
> Thanks, fixed when applying
>
>> > $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
>> > 	 --do new \
>> > 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
>> >
>> > lib.ynl.NlError: Netlink error: Numerical result out of range
>> > nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
>> > 	error: -34	extack: {'msg': 'integer out of range', 'unknown': [[type:4 len:36] b'\x0c\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x03\x00\xff\xff\xff\x7f\x00\x00\x00\x00\x08\x00\x01\x00\x08\x00\x00\x00'], 'bad-attr': '.ifindex'}
>> >
>> > Accept 0 since it used to be silently ignored.
>> >
>> > Fixes: 54c4ef34c4b6 ("openvswitch: allow specifying ifindex of new interfaces")
>> > Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
>> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> > ---
>> > CC: pshelar@ovn.org
>> > CC: andrey.zhadchenko@virtuozzo.com
>> > CC: brauner@kernel.org
>> > CC: dev@openvswitch.org
>> > ---  
>> 
>> Thanks for the quick follow up.  I accidentally broke my system trying
>> to setup to reproduce the syzbot splat.
>
> Ah. Syzbot pointed at my commit so I thought others will just think
> "not my bug" :)
>
>> The attribute here isn't used by the ovs-vswitchd, so probably why we
>> never caught an issue before.  I'll think about how to improve the
>> fuzzing on the ovs module.  At the very least, maybe we can have some
>> additional checks in the netlink selftest.
>
> Speaking of fuzzing - reaching out to Dmitry crossed my mind.
> When the first netlink specs got merged we briefly discussed
> using them to guide syzbot a little. But then I thought - syzbot did
> find this fairly quickly, it's more that previously we apparently had
> no warning or crash for negative ifindex so there was no target to hit.
>
>> I noticed that since I copied the definitions when building
>> ovs-dpctl.py, I have the same kind of mistake there (using unsigned for
>> ifindex).  I can submit a follow up to correct that definition.  Also,
>> we might consider correcting the yaml.
>
> FWIW I left the nla_put_u32() when outputting ifindex in the kernel as
> well.

I looked around and it is a bit inconsistent when sending the ifindex.
Some places are s32, some are u32, and doesn't seem to be any rhyme or
reason other than "feels good here."

> I needed s32 for the range because min and max are 16 bit (to
> conserve space in the policy) so I could not express the positive limit
> on u32. Whether ifindex is u32 or s32 is a bit of a philosophical
> question to me, as it only takes positive 31b values...

Yeah, we can always just use some number > INT_MAX, and we will have the
sign bit as well, so it isn't too important.


