Return-Path: <netdev+bounces-284793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id deocE4km+2kQXAMAu9opvQ
	(envelope-from <netdev+bounces-284793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E254D9B98
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3704F30238D1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E13370E4;
	Wed,  6 May 2026 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="nE5ssJzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbBj/oH9"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F259337BA4
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067035; cv=none; b=b/SpkQ+Wy+a39UsQ09YVdU+WaZTo8W12Lf8OT8JIBm6dk5ikHYASVzkOG3C74teYgHEgvKj6SiatyhvbmHylq+VoJhexXJ7D314UKpYnHphEhqyoHSzBegEi7f/NKX02REqoAln9WKj3ez668h1+v6JYS4n7caC+PlCUflqQAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067035; c=relaxed/simple;
	bh=PzJBEs0+U4l/payCrufmAhU6wkOyz13vUUppMBpOxr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTTzAgv1fvd3cbAsH7XK+8V1Rqvi2+Ln8NOEcKVOKCMbf3BkYmjK59GzMv8PmhU4dRYA68a+Qw88uajW9FnwYJxm+upa8VogcjcApbcd9EGPofCudXUetpFDeFiu70K+mXKpYu5HWJ0zmt1fs2uNGHPr72keaKNnt9JRJf3kVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=nE5ssJzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbBj/oH9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CD77EC0141;
	Wed,  6 May 2026 07:30:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 May 2026 07:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778067031; x=
	1778153431; bh=E0WA/jq0I9gnLB+Xm8Aat0HSvZ+luI0k9BALU5KYxEs=; b=n
	E5ssJzmFAA8JEqDV2EpCyOeUZqC7o9U1boYuKEq6kgENWLRW0TOB/SUKfpLpkTmh
	wQ8F3JM1XPq51xte9ydT0R3+NmTX4xdPpqn7u/27l5dWOxPwJ7jPxp+1ohJjldGQ
	fZ4HecCGh45pNr4X0iJR6wUwl+Up58zFOolMHagaKh7kpolqcCKMCZZYRkWh6FQp
	NvXq6xH4ayIQxyKu9LKiNER5LSBUvKB9ndukVYdEUpBCB2fYthCAclc/VLZK6Jee
	5XjkSI6ZPwa/MelhjxsHXlqczs2tHGYxBhnj7qVhe504p0ZmXD0KjMCsX/zs3eg1
	yH6IR1RkMZ9rrCbq3jPNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778067031; x=1778153431; bh=E0WA/jq0I9gnLB+Xm8Aat0HSvZ+luI0k9BA
	LU5KYxEs=; b=BbBj/oH94iF5JsEJjv8IH2RPL39zfLZT9RLuFEPxLQPtFMRQfSn
	/rx5Wz00tNyNp1n01VX5WO6ssTznVhyMQIMQrMuhZ9pS7NG1RXEWDsTcsrzLVxhI
	m8YXFU27Th42Uzd9NqeHlx2V+YOUlvix3ILm3YEy/EgAk1q8rTTyg6Uklr9Bugri
	UyAwA0vKYFjn6XM6KUy/SjxnAdJbIvQ7F7PCg4Ekihbunp8Bmwnb5Ps42loHyDC3
	iCt1Mz5uhgq3SQ0tzWAOsUladWTwTI7BVC+DIeliHnwEJNk82uD1+BEqUb8F3gY1
	OWD0aS5mzUzncK4skzcPRXg4hrtgTOsF2hg==
X-ME-Sender: <xms:Vib7aa1wye6TmkXQE3yaE0TOtQ11exm_Aj9dW5Y4CLDWMH6u5ci1ug>
    <xme:Vib7aY7SrUnUJc6Jq1fcZVvDAKHPODBB7sVcTi4t4DqzmoNFOxa02BNH8d7fCzwIv
    qTFg_0OtgPPCSDNxsNJ4MiHgfumVuZFOaRvVgdDdHxJ3QJU82GZINI>
X-ME-Received: <xmr:Vib7aeRzZ5EZhxYwnww058z0-nhtNgf8I8w6vz2y1_qDnjZZ4JHucpPggFZF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjvghthhifrghnihesphhurhgvshhtoh
    hrrghgvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epthgrrhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:Vib7aVVtCZwy8-uQOq1pVvPqMbxWNAXJqxn37-LTUCZ_YyT8VzHEbw>
    <xmx:Vib7abGBJK-AUayryrJZUnJ5JQ55qSP0Mp7mplZGWH4Thjo8gKBiwg>
    <xmx:Vib7aQcQO5dyOKmqEymPZZElbkiS2QM08UI9ep8D11Yk1RfVRisYUg>
    <xmx:Vib7acoqmRaW80sv-s6Pmp43AXSKGyBv3IQ4XoYlahp11w4BTf47iQ>
    <xmx:Vyb7aaoOjGkltBOzr6-KrRCYU2Ah_avcFxTlxE1RzIvHEgdn_ZIwSagv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 07:30:30 -0400 (EDT)
Date: Wed, 6 May 2026 13:30:28 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v13 5/6] tls: add hardware offload key update support
Message-ID: <afsmVLSn2tA7UP9W@krikkit>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-6-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429181016.3164935-6-rjethwani@purestorage.com>
X-Rspamd-Queue-Id: 96E254D9B98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284793-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

2026-04-29, 12:10:15 -0600, Rishikesh Jethwani wrote:
> On RX, the NIC may have already decrypted in-flight records with
> the old key before the peer's KeyUpdate is parsed, so the old
> AEAD, IV and rec_seq are retained on tls_offload_context_rx.
> tls_check_pending_rekey() invokes tls_device_rx_del_key() to drop
> the NIC key; otherwise post-KeyUpdate records (carrying new-key
> wire encryption) would be XOR'd with the retired key.
> tls_device_decrypted() classifies records by old_nic_boundary:
> 
>   - after the boundary: new-key record; drop the old key.
>   - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
>   - before, (partially) decrypted: reencrypt with the old key so SW
>     AEAD can decrypt with the new key.
>
> For mixed records skb->decrypted flags can be wrong (NIC clears
> them on auth failure); on -EBADMSG, tls_rx_rekey_retry() toggles
> those flags, decrements old_rec_seq to reuse the nonce, and
> retries once (gated by old_key_reencrypted).

Not blaming you for NIC behavior, but... the NIC passes up as
"decrypted" records that have failed decryption (because it was using
the wrong (old) key), or passes as "encrypted" the incorrectly
decrypted data (that it has "decrypted" with the old key)?

Or this is only the first record(s) after the KeyUpdate message, if
they fall within the same packet, the whole packet was "decrypted"
with the old key but only the KeyUpdate itself (and maybe some more
records before it) decrypted correctly ; but subsequent packets get
passed as !decrypted and don't need this reencrypt dance?

(this is maybe more of a question for Tariq or the other @nvidia
folks)


I haven't reviewed the whole patch at this point, because of Paolo's
suggestion and this confusion with the RX rekey.

> diff --git a/include/net/tls.h b/include/net/tls.h
> index ebd2550280ae..6891aa6b484c 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
[...]
> @@ -165,6 +181,11 @@ struct tls_offload_context_tx {
>  	void (*sk_destruct)(struct sock *sk);
>  	struct work_struct destruct_work;
>  	struct tls_context *ctx;
> +
> +	struct tls_sw_context_tx rekey_sw;	/* SW context for new key */
> +	struct cipher_context rekey_tx;		/* IV, rec_seq for new key */
> +	union tls_crypto_context rekey_crypto_send; /* Crypto for new key */
[...]
> @@ -253,6 +273,15 @@ struct tls_context {
>  			       */
>  	unsigned long flags;
>  
> +	/* TCP sequence number boundary for pending rekey.
> +	 * Packets with seq < this use old key, >= use new key.
> +	 */
> +	u32 rekey_boundary_seq;
> +
> +	/* Pointers to rekey contexts for SW encryption with new key */
> +	struct tls_sw_context_tx *rekey_sw_ctx;
> +	struct cipher_context *rekey_cipher_ctx;
> +
[...]
> @@ -311,6 +340,14 @@ struct tls_offload_context_rx {
>  	u8 resync_nh_reset:1;
>  	/* CORE_NEXT_HINT-only member, but use the hole here */
>  	u8 resync_nh_do_now:1;
> +	/* retry reencrypt of mixed record during rekey */
> +	u8 old_key_reencrypted:1;
> +	/* tls_dev_add deferred until old key is freed */
> +	u8 dev_add_pending:1;
> +	struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
> +	char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
> +	char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
> +	u32 old_nic_boundary; /* TCP seq: NIC switched to next key */

I think it would be nice to group the new fields in those 3 structs
into embedded "untyped" structs:

    struct tls_offload_context_rx {
        /* existing fields */

        struct {
            struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
            char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
            char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
            u32 old_nic_boundary; /* TCP seq: NIC switched to next key */
        } rekey;

        /* other fields */
    };

and then remove the "rekey_" prefixes in
tls_offload_context_tx/tls_context.

[note to self: in the near future we should probably switch all those
comments to kdoc, and consider splitting the offload_contexts into
NIC-visible and internal-only chunks]


> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index cd26873e9063..51f1cc783336 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
[...]
> @@ -159,6 +161,262 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
> +static bool tls_has_unacked_records(struct tls_offload_context_tx *offload_ctx)
> +{
[...]
> +static int tls_device_init_rekey_sw(struct sock *sk,
> +				    struct tls_context *ctx,
> +				    struct tls_offload_context_tx *offload_ctx,
> +				    struct tls_crypto_info *new_crypto_info)
> +{
[...]
> +static int tls_device_start_rekey(struct sock *sk,
> +				  struct tls_context *ctx,
> +				  struct tls_offload_context_tx *offload_ctx,
> +				  struct tls_crypto_info *new_crypto_info)
> +{
[...]
> +static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx)
> +{

For tls_device_complete_rekey(): refactor the bits that overlap with
tls_set_device_offload_initial() into a shared helper?

I think it'd be better to reshuffle all this so that
tls_has_unacked_records is just next to tls_tcp_clean_acked (because
they do something a bit similar, both deal with unacked records), and
move those 3 rekey functions next to tls_set_device_offload_rekey().


> @@ -980,13 +1269,144 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	return err;
>  }
>  
> +/*
> + * temporarily swap in the old key, run
> + * tls_device_reencrypt(), then restore the current key.
> + */
> +static int tls_old_key_reencrypt(struct sock *sk,
> +				 struct tls_offload_context_rx *ctx,
> +				 struct tls_sw_context_rx *sw_ctx,
> +				 struct tls_context *tls_ctx)
> +{

Why a separate helper (with a very confusing name), with then a
wrapper that does almost nothing else than call tls_old_key_reencrypt()?

[...]
> +static int tls_device_reencrypt_old_key(struct sock *sk,
> +					struct tls_offload_context_rx *ctx,
> +					struct tls_sw_context_rx *sw_ctx,
> +					struct tls_context *tls_ctx)
> +{
[...]
> +void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
> +{
[...]
> +static int tls_device_dev_add(struct sock *sk, struct tls_context *tls_ctx,
> +			      struct net_device *netdev,
> +			      struct tls_crypto_info *crypto_info,
> +			      u32 cur_seq, bool is_rekey)
> +{
[...]
> +static void tls_device_deferred_dev_add(struct sock *sk,
> +					struct tls_context *tls_ctx,
> +					struct tls_offload_context_rx *ctx)
> +{

Same here, in terms of code organization, I'd move those 3
 ->tls_dev_{add,del} wrappers to the top of the file, so that the
reencrypt/decrypted/old_key function(s) stay grouped together.


>  int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  {

[...]
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index fd04857fa0ab..ab701f166b57 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -371,6 +371,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>  
>  	if (ctx->tx_conf == TLS_SW)
>  		tls_sw_cancel_work_tx(ctx);
> +	else if (ctx->tx_conf == TLS_HW && ctx->rekey_sw_ctx)
> +		tls_sw_cancel_work_tx(ctx);
>  
>  	lock_sock(sk);
>  	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
> @@ -711,64 +713,68 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>  	}
>  
>  	if (tx) {
> -		if (update && ctx->tx_conf == TLS_HW) {
> -			rc = -EOPNOTSUPP;
> -			goto err_crypto_info;
> -		}
> -
> -		if (!update) {
> -			rc = tls_set_device_offload(sk);
> -			conf = TLS_HW;
> -			if (!rc) {
> +		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
> +		conf = TLS_HW;
> +		if (!rc) {
> +			if (update) {
> +				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);

tls_set_device_offload* could succeed without completing the rekey, so
we would increment this counter, and then the async rekey completion
could fail. In that case, we will end up with 2 stats increases for a
single rekey.

Probably better to add a pair of REKEYINPROGRESS counters (similar to
the CURR* counters) that get incremented if we start a rekey but can't
finish it immediately, and decremented when we complete the rekey (and
also increment the corresponding REKEYOK/REKEYFAIL counter at that
time). If we're able to complete the rekey before returning from
do_tls_setsockopt_conf, we would increment the REKEYOK/REKEYFAIL
immediately.

This would avoid the inconsistent number of stats increases, and allow
users to see that a rekey is in progress.

> +			} else {
>  				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
>  				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
> -				goto out;
>  			}
> -		}
> -
> -		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
> -		if (rc)
> +		} else if (update && ctx->tx_conf == TLS_HW) {
> +			/* HW rekey failed - return the actual error.
> +			 * Cannot fall back to SW for an existing HW connection.
> +			 */
>  			goto err_crypto_info;

In this case, the REKEYHWFAIL will not always be incremented (for
example when tls_device_start_rekey fails, or tls_sw_ctx_init on the
RX side).

[...]
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 1412b3dcce4c..fc60e8c0f24c 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
[...]
> @@ -1802,6 +1801,8 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
>  	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
>  		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
>  
> +		/* Stop NIC from XOR-ing post-KU records with the retired key */

I think "tls_device_rx_del_key" tells us everything we need to know in
this context, and "XOR-ing post-KU records" is just noise here. Please
remove this comment.


> @@ -2714,11 +2758,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
>  		sw_ctx_tx = ctx->priv_ctx_tx;
>  	}
>  
> -	crypto_init_wait(&sw_ctx_tx->async_wait);
> -	atomic_set(&sw_ctx_tx->encrypt_pending, 1);
> -	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
> -	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
> -	sw_ctx_tx->tx_work.sk = sk;
> +	tls_sw_ctx_tx_init(sk, sw_ctx_tx);
>  
>  	return sw_ctx_tx;
>  }
> @@ -2861,11 +2901,9 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
>  			goto free_aead;
>  	}
>  
> -	if (!new_crypto_info) {
> -		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
> -		if (rc)
> -			goto free_aead;
> -	}
> +	rc = crypto_aead_setauthsize(*aead, prot->tag_size);
> +	if (rc)
> +		goto free_aead;

If you're going to do this (I'm not sure why we want this), fix up the
comment just above crypto_aead_setkey (8 lines above this) that says
"setkey is the last operation that could fail during a rekey", or do
the change in a way that setkey is still the last op that can fail.

-- 
Sabrina

