Return-Path: <netdev+bounces-264744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGAKBIe0qml9VgEAu9opvQ
	(envelope-from <netdev+bounces-264744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:03:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0721F67B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C02623045A99
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCA349B18;
	Fri,  6 Mar 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GVzXkSNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3lOvFtf"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018923C516
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795001; cv=none; b=iterpLbKfL1GaipJtGbEWer9rqI/MZwE5bFcPes9vBiLcOiYbnWvMmg11mva0y9IZ3syrXMMnNYufLjLVyQNe7MGyIrRgcipe2NF/AI08yc443JaMcRWBqL7rfrIHrgtaIeBupqatBYfQkTBDd2YevSTkOhX/CqEybeF1g4c6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795001; c=relaxed/simple;
	bh=PIvre5oKJmAYKAU5/KLObYZpm7u8CjW4WK0kaQiiXbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk5dIFhy7pQvXzaWr+cgjjaCVJyb71ao3YGlQ5gief4/KqezYu4Utgeqlcr0rKO6/1eFAIQ7Cl539eqE3tVhzvbvUaLLAxJruGyo0wIGYxCa7zZr53c5uh3Cu1zuDlcKjX8jMgOuSBwKelt9yON31aN9dGaWZhriAlIRQsAswsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GVzXkSNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3lOvFtf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58942140021F;
	Fri,  6 Mar 2026 06:03:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 06:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772794998; x=
	1772881398; bh=dLL/nLB3sa5pSYrC5t9KIx0W5G+Id7KRhtEZd1fY5y0=; b=G
	VzXkSNUWnM/aIBCBT/Ft0XWkRzSRyS2wlPdekvdMNa0G/Pdy42HoBACeNnbcgMzn
	64Gqk0UAhZrDiL5R1vMzwrs6WcQVq63KFjJCwvmPkCwlfmnb8dO1GveEPq1hyk2K
	/4xuPZ03pVPKssVwF/UZjgz0Rv3/ox4MLMuU0bU0CgAgEIQFA4G0dR4upn0S40pM
	S1rvB/ElE1yXTmTEDdQ+axjsQWTsjVkJEolDeiMmDiNeZo3I0HYe7C08cIJte6KX
	t9iypQY/b/qU3U1e2Kiw3Y67pgp/E58cpkEakKDnyP7vAnw7EL6OP/xhngJfZUqu
	LVUbE5nP5IreUpH9WosTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772794998; x=1772881398; bh=dLL/nLB3sa5pSYrC5t9KIx0W5G+Id7KRhtE
	Zd1fY5y0=; b=j3lOvFtfvphQc8wnJQlcqJXDrz0X4cpP9gDYLKNxAk9hqp+0eX9
	8Kg3h9RSz9O7DpRgT8tJEB0QieyTFn2Dy8Bk/PDN6sNk6uA/ijdA1zSZHmb8xFOe
	3WDK5r594+MjFh9tLT8D8m9FVmY2DKPPT7d2W3p+jS1xdrLatN7FBCbvBusx7z8h
	y2PIRbZ1TqTDABBjKI1ncC7AKTRgxxErQwM1c83/fo5+OEG29DDuxNqP5BGR/E8h
	cFwP0YA2aC5w9xkqD1856Ngac8pXJWYVttDSQEeDZqexGW2PvVFK90VKw7NMTK6l
	MXS2EG0h4yOluTXTi5qdfopVVTaxOR09EHw==
X-ME-Sender: <xms:dbSqaT3j9k40_pqt4hZ7nTGrDvXSd36ng1xFrTwJAvBlGe4fdM4AOw>
    <xme:dbSqafBMEGWidhzXObobNVMnw5tvQT2Lt_UabAhj0L1u2be4vny6JLxp3GJ3E_obh
    0OxYKZLRyRZTGEVcswQ2TkeyfULpBJwz8A29TmGa9b8tHvfIyf21Mk>
X-ME-Received: <xmr:dbSqafh_OS-meqaQ-FXArseEzbD0v1YqgFU9Fi9f3Gxu-L6BXtlJC5v8MogJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeludefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtghomhdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dbSqaRPbUvXTSGjork0Wys6UIAEkzH3KywFU6bCD78mtFAN6jLej6A>
    <xmx:dbSqaf9WVjVkii5d9YgqeHwCWnwxo-AqXOiktAGQ1PYgLzvZBKkrlg>
    <xmx:dbSqaSd1wx8vwR1kE5VpUeB_ouWH4C6by9x1jzi69e0OsVL8gjJw8Q>
    <xmx:dbSqaezLISYCcBBm841loGJB-q6JOt7rH9vp-K6Jqr-JNkQuw9TL-Q>
    <xmx:drSqafa6_-MREMeStvqG91MXwa4sQj4wdP_l6JMaG6WO3_TUbpS3rkVB>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 06:03:17 -0500 (EST)
Date: Fri, 6 Mar 2026 12:03:15 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, pabeni@redhat.com,
	netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net] ovpn: Fix race condition in ovpn_dellink()
Message-ID: <aaq0cxEEkPf7CDV4@krikkit>
References: <aaVgJ16edTfQkYbx@v4bel>
 <6aa197ce-9e72-473c-a8c9-d190d85fb625@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aa197ce-9e72-473c-a8c9-d190d85fb625@openvpn.net>
X-Rspamd-Queue-Id: 66D0721F67B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264744-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Sorry Antonio, things are a bit busy over here, I'm finally getting to
this.

2026-03-03, 21:15:59 +0100, Antonio Quartulli wrote:
> Hi,
> 
> On 02/03/2026 11:02, Hyunwoo Kim wrote:
> > When ovpn_dellink() is called, it invokes
> > cancel_delayed_work_sync() to stop keepalive_work before freeing
> > the device.
> > However, ovpn_nl_peer_new_doit() runs without any lock shared
> > with the RTNL path, so keepalive_work can be scheduled after
> > cancel_delayed_work_sync() returns.
> > 
> > The following is a simple race scenario:
> > 
> >            cpu0                            cpu1
> > 
> > ovpn_dellink(dev)
> >    cancel_delayed_work_sync(keepalive_work)
> >                                     ovpn_nl_peer_new_doit()
> >                                       ovpn_nl_peer_modify()
> >                                         ovpn_peer_keepalive_set()
> >                                           mod_delayed_work(keepalive_work)
> > 
> > To prevent this race condition, cancel_delayed_work_sync() is
> > replaced with disable_delayed_work_sync().
> 
> I was about to agree on your fix, however, it seems there is a larger issue
> here and this patch is just addressing one symptom.
> 
> If you are truly able to execute the whole ovpn_nl_peer_new_doit() after
> cancel_delayed_work_sync() and before the netdev refcounter reaches 0, I
> think we may get stuck in the "wait for device to be freed..." loop.
> 
> That's because the ovpn_peer_new() will acquire a reference to the netdev,
> preventing it to be fully released.
> 
> 
> Sabrina, do you have any thought on this?
> It seems as if there is no safe guard against adding peers while destroying
> the interface.

Feel free to add:

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..3bf6ea5f7208 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -214,6 +214,10 @@ static void ovpn_dellink(struct net_device *dev, struct list_head *head)
 
 	cancel_delayed_work_sync(&ovpn->keepalive_work);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
+
+	pr_warn("sleeping\n");
+	msleep(10000);
+
 	unregister_netdevice_queue(dev, head);
 }
 

to help reproduce the race, I usually do something like that if it's
possible to sleep in that context.


I think you're right, the newly-added peer will miss
ovpn_peers_free. Can we simply move cancel_delayed_work_sync +
ovpn_peers_free to ndo_uninit and not provide a dellink?

At ndo_uninit, the netdevice is no longer listed so PEER_NEW won't
find it, but delaying the release of the reference on the netdev via
peer cleanup should still be ok (unregister_netdevice_many_notify
calls unlist_netdevice and then ndo_uninit, then we add it to the
todo_list and netdev_run_todo processes that list and does
netdev_wait_allrefs_any).

-- 
Sabrina

