Return-Path: <netdev+bounces-214451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA647B299BB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D6C189F219
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913B2750ED;
	Mon, 18 Aug 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TBo+RssG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hkq8SzjE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TBo+RssG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hkq8SzjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC71DD877
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498710; cv=none; b=jt7nofVEUTAlXjyXgB62IAJ8kDsiHZxaECzc9MQgavpe/OKOCgsqOVj/y5XtPekflJ2VOsBm+RVPXKEaij36dYJhg976fZJPT9Xvn/MnSmj5IhA6jDMqzw2xbL9d5z0tTLTKAFkT17zBBdKGmZ1ybHlG3dM71RL85o1nHMcSdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498710; c=relaxed/simple;
	bh=CE5qQ851TpBnQeg0Q5ojnAghTuzyEee3eJY4tSKcJnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqLIZhj4t2taCArMWi0skGTwUMG4AZBL9qCIY4ydOw4ABGDox/U40VLiTrW03WjgPg/37c4JOOh+W9F+/1MwxEpZrbtsD0/m4D64P7ikA7D2+67eh1ObItV/bZdT2RhwmDw8nX8+Exx24Mn5nseWMgB63cvuTy8vCRASGUwknPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TBo+RssG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hkq8SzjE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TBo+RssG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hkq8SzjE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F027211E6;
	Mon, 18 Aug 2025 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755498705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKNYr7Sr1Rv8RUdhjv8p0XIb/kkQer4wA6muKTtrKVo=;
	b=TBo+RssGZrAiSXlAKNYgmq/qsRNusV1X0Kxs1D76VfxPt23twt41rpGreA31MJytupNgPw
	CNgPdxnsmEEtLuKNgc0SZTbKMZBBR7y9ZyPQYtINVXymVzBbcNGTMCmkv4eGtCe3Vwrd0l
	wkO77Mad+/7JqdjMQ0DcDxRvmJGRc3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755498705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKNYr7Sr1Rv8RUdhjv8p0XIb/kkQer4wA6muKTtrKVo=;
	b=hkq8SzjE9MDdV98SBoYUFjno9CxF6K/O7qbDcPGEheiajZGZiXZINwkZ0Lm8yOGr2WCN+F
	iHZ6kQ9MJmiYk4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755498705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKNYr7Sr1Rv8RUdhjv8p0XIb/kkQer4wA6muKTtrKVo=;
	b=TBo+RssGZrAiSXlAKNYgmq/qsRNusV1X0Kxs1D76VfxPt23twt41rpGreA31MJytupNgPw
	CNgPdxnsmEEtLuKNgc0SZTbKMZBBR7y9ZyPQYtINVXymVzBbcNGTMCmkv4eGtCe3Vwrd0l
	wkO77Mad+/7JqdjMQ0DcDxRvmJGRc3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755498705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKNYr7Sr1Rv8RUdhjv8p0XIb/kkQer4wA6muKTtrKVo=;
	b=hkq8SzjE9MDdV98SBoYUFjno9CxF6K/O7qbDcPGEheiajZGZiXZINwkZ0Lm8yOGr2WCN+F
	iHZ6kQ9MJmiYk4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 792F813686;
	Mon, 18 Aug 2025 06:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /DV1GdDIomhdAgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 06:31:44 +0000
Message-ID: <a9ea0abf-1f11-4760-80b8-6a688e020093@suse.de>
Date: Mon, 18 Aug 2025 08:31:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/1] net/tls: allow limiting maximum record size
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, chuck.lever@oracle.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, borisp@nvidia.com,
 john.fastabend@gmail.com
Cc: alistair.francis@wdc.com, dlemoal@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250808072358.254478-3-wilfred.opensource@gmail.com>
 <20250808072358.254478-5-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250808072358.254478-5-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 8/8/25 09:24, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> This patch adds support for retrieving the negotiated record size limit
> during a handshake, and enforcing it at the TLS layer such that outgoing
> records are no larger than the size negotiated. This patch depends on
> the respective userspace support in tlshd [2] and GnuTLS [3].
> 
> [1] https://www.rfc-editor.org/rfc/rfc8449
> [2] https://github.com/oracle/ktls-utils/pull/112
> [3] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   Documentation/netlink/specs/handshake.yaml |  3 +++
>   include/net/tls.h                          |  2 ++
>   include/uapi/linux/handshake.h             |  1 +
>   net/handshake/genl.c                       |  5 ++--
>   net/handshake/tlshd.c                      | 29 +++++++++++++++++++++-
>   net/tls/tls_sw.c                           |  6 ++++-
>   6 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index b934cc513e3d..4e6bc348f1fd 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -84,6 +84,9 @@ attribute-sets:
>           name: remote-auth
>           type: u32
>           multi-attr: true
> +      -
> +          name: record-size-limit
> +          type: u32
>   
>   operations:
>     list:
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 857340338b69..02e7b59fcc30 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -250,6 +250,8 @@ struct tls_context {
>   			       */
>   	unsigned long flags;
>   
> +	u32 tls_record_size_limit;
> +
>   	/* cache cold stuff */
>   	struct proto *sk_proto;
>   	struct sock *sk;
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index 3d7ea58778c9..0768eb8eb415 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -54,6 +54,7 @@ enum {
>   	HANDSHAKE_A_DONE_STATUS = 1,
>   	HANDSHAKE_A_DONE_SOCKFD,
>   	HANDSHAKE_A_DONE_REMOTE_AUTH,
> +	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
>   
>   	__HANDSHAKE_A_DONE_MAX,
>   	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index f55d14d7b726..44c43ce18361 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>   };
>   
>   /* HANDSHAKE_CMD_DONE - do */
> -static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
> +static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] = {

Shouldn't that be 'HANDSHAKE_A_DONE_MAX'?

>   	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
>   	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
>   	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
> +	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] = { .type = NLA_U32, },
>   };
>   
>   /* Ops table for handshake */
> @@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
>   		.cmd		= HANDSHAKE_CMD_DONE,
>   		.doit		= handshake_nl_done_doit,
>   		.policy		= handshake_done_nl_policy,
> -		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
> +		.maxattr	= HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,

HANDSHAKE_A_DONE_MAX - 1?

>   		.flags		= GENL_CMD_CAP_DO,
>   	},
>   };
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index d6f52839827e..f4e793f6288d 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -19,6 +19,7 @@
>   #include <net/handshake.h>
>   #include <net/genetlink.h>
>   #include <net/tls_prot.h>
> +#include <net/tls.h>
>   
>   #include <uapi/linux/keyctl.h>
>   #include <uapi/linux/handshake.h>
> @@ -37,6 +38,8 @@ struct tls_handshake_req {
>   	key_serial_t		th_certificate;
>   	key_serial_t		th_privkey;
>   
> +	struct socket		*th_sock;
> +
>   	unsigned int		th_num_peerids;
>   	key_serial_t		th_peerid[5];
>   };
> @@ -52,6 +55,7 @@ tls_handshake_req_init(struct handshake_req *req,
>   	treq->th_consumer_data = args->ta_data;
>   	treq->th_peername = args->ta_peername;
>   	treq->th_keyring = args->ta_keyring;
> +	treq->th_sock = args->ta_sock;
>   	treq->th_num_peerids = 0;
>   	treq->th_certificate = TLS_NO_CERT;
>   	treq->th_privkey = TLS_NO_PRIVKEY;
> @@ -85,6 +89,27 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
>   	}
>   }
>   
> +static void tls_handshake_record_size(struct tls_handshake_req *treq,
> +				      struct genl_info *info)
> +{
> +	struct tls_context *tls_ctx;
> +	struct nlattr *head = nlmsg_attrdata(info->nlhdr, GENL_HDRLEN);
> +	struct nlattr *nla;
> +	u32 record_size_limit;
> +	int rem, len = nlmsg_attrlen(info->nlhdr, GENL_HDRLEN);
> +
> +	nla_for_each_attr(nla, head, len, rem) {
> +		if (nla_type(nla) == HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT) {
> +			record_size_limit = nla_get_u32(nla);
> +			if (treq->th_sock) {
> +				tls_ctx = tls_get_ctx(treq->th_sock->sk);
> +				tls_ctx->tls_record_size_limit = record_size_limit;
> +			}
> +			break;
> +		}
> +	}
> +}
> +
>   /**
>    * tls_handshake_done - callback to handle a CMD_DONE request
>    * @req: socket on which the handshake was performed
> @@ -98,8 +123,10 @@ static void tls_handshake_done(struct handshake_req *req,
>   	struct tls_handshake_req *treq = handshake_req_private(req);
>   
>   	treq->th_peerid[0] = TLS_NO_PEERID;
> -	if (info)
> +	if (info) {
>   		tls_handshake_remote_peerids(treq, info);
> +		tls_handshake_record_size(treq, info);
> +	}
>   
>   	if (!status)
>   		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index fc88e34b7f33..70ffc4f5e382 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1024,6 +1024,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   	ssize_t copied = 0;
>   	struct sk_msg *msg_pl, *msg_en;
>   	struct tls_rec *rec;
> +	u32 tls_record_size_limit;
>   	int required_size;
>   	int num_async = 0;
>   	bool full_record;
> @@ -1045,6 +1046,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   		}
>   	}
>   
> +	tls_record_size_limit = min_not_zero(tls_ctx->tls_record_size_limit,
> +					     TLS_MAX_PAYLOAD_SIZE);
> +
>   	while (msg_data_left(msg)) {
>   		if (sk->sk_err) {
>   			ret = -sk->sk_err;
> @@ -1066,7 +1070,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   		orig_size = msg_pl->sg.size;
>   		full_record = false;
>   		try_to_copy = msg_data_left(msg);
> -		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
> +		record_room = tls_record_size_limit - msg_pl->sg.size;
>   		if (try_to_copy >= record_room) {
>   			try_to_copy = record_room;
>   			full_record = true;

Otherwise:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

