Return-Path: <netdev+bounces-270600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHscMCJqwWnVSwQAu9opvQ
	(envelope-from <netdev+bounces-270600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:28:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F992F8240
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02EE7302487D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403923B0ACC;
	Mon, 23 Mar 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4GRK5pp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BF388377
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281217; cv=none; b=FtB0A4Z5OevcSUPSEq/rBU5phA8SY2g+xY1xX/1fXvM6KP2vLx6tPsdr+zobb4ORneLqbEJzDduWO40Y4lBv1XXrruwS+6wSHLxjbb9P22HFMuxvp4J5ewI+oqQvGV1dwcuzzNfSsevP1xqw6pqPfTglDWnEQtTNBBtVe3dA6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281217; c=relaxed/simple;
	bh=UMrez3UixCqOwCj/V0WduuhvRKIIALsXFhXMF9WaZcE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XdZlVqU8qu9FA1NGLB9kechhA461dNnV0RwCW/44h/wlpDk2FuifLnLPSPkxX6+Lye/M8It5/wUjwC35EuDzNdYdAJgJR0HGmzSaUq+BhxUFsGYwZeDnT50gj17i+3ee92bN5i8evPhYZykVEP/M3zpLgN5ekkE0jEgz+qlTzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4GRK5pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460B0C4AF0B;
	Mon, 23 Mar 2026 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281217;
	bh=UMrez3UixCqOwCj/V0WduuhvRKIIALsXFhXMF9WaZcE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k4GRK5ppw+SkFVIoekpk/5KYRtlN2c8482sazkuwVsMM1f5aJYaPtWnMqbP6pyHFw
	 AVMg55B4RSTgh5Iu88kNFjR5xEEL8gryBe2J0o0WweBzAA6SVmHNKiKvpe/7Frv3Pl
	 SnE4kC+7FTLQUX7NvRxjxLoAH1Jlh7TLPU1jqHbNT+INkZROtbX4QHAZhTwU4Ny0gE
	 YrQ+bvxybaMZMMn6PcTTKtRgrLK2DyCMYvU85J1R2BvPqv/4DMxo8dy8pxLgdEdLjA
	 sWfxmDdcNnEXoCddFcrodQqNlNlja2lqGhfV+jyXBDD0u1jP9CLgKB8AnxPQ9hYf3+
	 Y2it8rwWK6NIA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3E114F40082;
	Mon, 23 Mar 2026 11:53:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 11:53:36 -0400
X-ME-Sender: <xms:AGLBaTIUDy74Bdg-ndT75luRvsnzhtFChZpuvk2IPaxzhkpbso6vdw>
    <xme:AGLBaR9ZN_4LXoqN8BCOQlbypBAgQo5DuQxoXAYyjrtBNopVWbUTU1gBTK-VwZVTm
    GRodCF63235gRJnGzkS0J2PFp_B6iH3jhpWEIC-A62I-QSUbBSHy1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdq
    hhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthh
    hutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsugesqhhuvggr
    shihshhnrghilhdrnhgvthdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AGLBaQyIkt0P_9Xg14RFc3GmuYXIuFWd7Bc-vYp5gM-cDY0T6rtgpg>
    <xmx:AGLBaeUU_CL4ExfoLkMlDxry9bFFiqribOJJDEoGgYTr-02QFyBskA>
    <xmx:AGLBaSP_EK3aDI7huAGpJ9cOcWgIZmng86ujxEP08PqOF-tCjbkuOQ>
    <xmx:AGLBaQAPIxJnMo58zz3m_YfwYggQLis9WMuNVIFMLs2neGTiKpCpNA>
    <xmx:AGLBafcg9J_gm9xmadbPVgnS8n7zR-4z0znmziy06LPpYCoQkS4d5NHn>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 15732780070; Mon, 23 Mar 2026 11:53:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARm2f9X8njS-
Date: Mon, 23 Mar 2026 11:53:15 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>
Message-Id: <72fb84f7-8d85-4a32-a3e0-f4aa77cf4de2@app.fastmail.com>
In-Reply-To: <acFK4DWAD5h_Oc0f@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <acFK4DWAD5h_Oc0f@krikkit>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption in
 read_sock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270600-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C8F992F8240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, Mar 23, 2026, at 10:14 AM, Sabrina Dubroca wrote:
> 2026-03-17, 11:04:21 -0400, Chuck Lever wrote:
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 5ae7e0c026e4437fe442c3a77b0a6d9623816ce1..bc500ba7ce81eb33763c37a8b73473c42dc66044 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c

>> @@ -2373,25 +2387,61 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>>  	decrypted = 0;
>>  	for (;;) {
>>  		struct tls_decrypt_arg darg;
>> +		int nr_async = 0;
>>  
>> -		/* Phase 1: Submit -- decrypt one record onto rx_list. */
>> +		/* Phase 1: Submit -- decrypt records onto rx_list. */
>>  		if (skb_queue_empty(&ctx->rx_list)) {
>> -			err = tls_rx_rec_wait(sk, NULL, true, released);
>> -			if (err <= 0)
>> +			while (nr_async < TLS_READ_SOCK_BATCH) {
>> +				if (nr_async == 0) {
>> +					err = tls_rx_rec_wait(sk, NULL,
>> +							      true,
>> +							      released);
>> +					if (err <= 0)
>> +						goto read_sock_end;
>> +				} else {
>> +					if (!tls_strp_msg_ready(ctx)) {
>> +						tls_strp_check_rcv_quiet(&ctx->strp);
>> +						if (!tls_strp_msg_ready(ctx))
>> +							break;
>
> This (and tls_rx_rec_wait) looks like tls_strp_check_rcv_quiet should
> return the value of msg_ready.
>
> This is also not very different from tls_rx_rec_wait(nonblock=true),
> why are you separating the nr_async>0 case and open-coding the core
> operations from tls_rx_rec_wait()?

tls_rx_rec_wait() is designed for the blocking first-record case
with full error/shutdown handling. The batch loop needs a light-
weight non-blocking poll with different semantics: "is another
record already available? If not, stop." Reusing tls_rx_rec_wait()
would require either adding more parameters to skip irrelevant
checks, or having the caller distinguish -EAGAIN (no record) from
real errors -- both of which would be more complex than the
current code.

My calculus was that the code duplication was a more readable
choice than building a single complicated helper that would
obfuscate the two flows.

-- 
Chuck Lever

