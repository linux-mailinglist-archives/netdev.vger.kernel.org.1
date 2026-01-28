Return-Path: <netdev+bounces-254111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHSmBkioeWl/yQEAu9opvQ
	(envelope-from <netdev+bounces-254111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4303B9D57F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10CC7300F142
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFB331212;
	Wed, 28 Jan 2026 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="JlEhujSe"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA06156236
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580611; cv=none; b=e3KXQclqj8xG2Y3gxWlDChug/3bierqpSAfMNfQNBxo8nKcVGkcOIBjrAckPoMrYFXfH3k9xQE05wYVoXjk77GVa2uWNhSvmY/n+0wWf22pAQK83kbnBq+JDgkqwnZ7p94q89j9H8/bTJBiSWVPKxuh9WETcXfnwvCSXwrhIAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580611; c=relaxed/simple;
	bh=iNZ8Al+rH+JmE0vug97fQvY6odP/ZYC95kBx+QhnTxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKd/rP9qWuzuEvD9Og1fkPDTEo7j8HZ8VRKcxTpvet40AR28lKcOihS4VSdeQEwy+4h6KNCuZRfnWrUUso0qWoqWxCHbs4XrXFwfljhgKtiyI5X5cren/+0FK7KFSLRqWPb6ru+n9UPlKFqX6wVhItkO3onrVP94AySjZWsjmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=JlEhujSe; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (85.154.13.160.dy.iij4u.or.jp [160.13.154.85])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60S69wpg032523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 15:09:59 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=w/u1fzObb/vQ4nIOqm+p737l4YnAfCnIUy3FBydAJtY=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769580600; v=1;
        b=JlEhujSeU7vtv0/+BGamrTo9zGKFrnl3aXcsdlrX/d9eM5EuSJ6vf0u6ktA2ZOa0
         dKazCB6JrQocTwpIpRv53UE3OmnR4q2ows6LZRMj5OqNtEM5SlTEIdiP/p/gRJTC
         tCvYrh7FEAhjEfsIuMVrnmRS2VPAExRkXm6+P3L9kL+/+A3qGHif6kGlBW12F9Vd
         hwmxRC6nRaX1P89+LHPEsScRH2s6sZDKR0EDcvCTiwR3zRnNpg470z2Yl5aLLqSg
         26HdxT8y7NgHu/Ae9K5Bb4sZ0oiC9qUUKsURmE6HDts1YshC2BstxtQxomUo1X16
         gpYGebMa52jiyi0MWgfNpA==
From: Kohei Enju <kohei@enjuk.jp>
To: anthony.l.nguyen@intel.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, enjuk@amazon.com,
        intel-wired-lan@lists.osuosl.org, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, piotr.kwapulinski@intel.com,
        pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com,
        takkozu@amazon.com
Subject: Re: [PATCH iwl-next v4 3/3] igb: allow configuring RSS key via
Date: Wed, 28 Jan 2026 06:09:44 +0000
Message-ID: <20260128060958.6333-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <f521fae5-54d7-4a8a-a190-80e29b6275d8@intel.com>
References: <f521fae5-54d7-4a8a-a190-80e29b6275d8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254111-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4303B9D57F
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 14:33:24 -0800, Tony Nguyen wrote:

> On 1/25/2026 5:12 AM, Kohei Enju wrote:
> > On Tue, 20 Jan 2026 18:34:40 +0900, Takashi Kozu wrote:
> > 
> >> Change igc_set_rxfh() to accept and save a userspace-provided
> >> RSS key. When a key is provided, store it in the adapter and write the
> >> E1000 registers accordingly.
> >>
> >> This can be tested using `ethtool -X <dev> hkey <key>`.
> >>
> >> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> >> ---
> >>   drivers/net/ethernet/intel/igb/igb.h         |  1 +
> >>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 49 +++++++++++---------
> >>   drivers/net/ethernet/intel/igb/igb_main.c    |  3 +-
> >>   3 files changed, 30 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> >> index 8c9b02058cec..2509ec30acf3 100644
> >> --- a/drivers/net/ethernet/intel/igb/igb.h
> >> +++ b/drivers/net/ethernet/intel/igb/igb.h
> >> @@ -657,6 +657,7 @@ struct igb_adapter {
> >>   	u32 rss_indir_tbl_init;
> >>   	u8 rss_indir_tbl[IGB_RETA_SIZE];
> >>   	u8 rss_key[IGB_RSS_KEY_SIZE];
> >> +	bool has_user_rss_key;
> > 
> > Hi Kozu-san.
> > 
> > While preparing for testing, I noticed that now 'has_user_rss_key' is
> > not necessary.
> > 
> > Since netdev_rss_key_fill() is called in igb_sw_init() and igb_sw_init()
> > is called only once for the adapter's lifetime, adapter->rss_key
> > wouldn't be changed except for user-intended change.
> > 
> > I'd drop that flag and related code (see below)
> 
> Hi Kohei,
> 
> I believe this igb implementation was based on your igc implementation 
> which also has the same. Would it be possible for you to update the igc 
> to do this as well?

Yes, you're right. I'd love to do that and post as new version, 
so could you drop the series[1] from tnguy/next-queue.git?

[1] https://lore.kernel.org/intel-wired-lan/20251025150136.47618-1-enjuk@amazon.com/

> 
> Thanks,
> Tony

