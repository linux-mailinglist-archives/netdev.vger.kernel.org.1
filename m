Return-Path: <netdev+bounces-301989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FrqEEqU/PWqx0AgAu9opvQ
	(envelope-from <netdev+bounces-301989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:48:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F486C6CB6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:48:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=R492jBKP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301989-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301989-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8263300532A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891436492C;
	Thu, 25 Jun 2026 14:47:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E12F12D4
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398877; cv=none; b=XxDiBOpY3W2saeFiegsDRntjrwfnxLhtQtdwwAxGkYTItMMXUeV5/VKdKoL3YrSqxC5AJUD3Mo7VO2gKNNFephyrpW3Bx+Wc8vE6teQMvsrXEG5yocx5P3jJA7/NT0BfvS/HIEe3gcJTPeo3vTlRwkNdhn9UnfUXdJ8mkXQnhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398877; c=relaxed/simple;
	bh=b7nIwf0SKHvAA694d5TUaIcATU4pgXwfs/ZG5hIaxnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYVvDOAsdkbNdHpmmhoZof83KJSZ6j73GWGXyIaFb5ojIg3AanRR+j/McrveUMIt7FDiv56wW52fQPP45wLjIcL2710ig9fXIDu41g9Op8uGKXBvEooYWOStwEa7j0AqkzanBNh83R+4LbGw1wsQry0XWp8EjvY5Ab/kfTQRsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=R492jBKP; arc=none smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c07ea058c1aso398884066b.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782398871; x=1783003671; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjX8t8yDdLY9x6HuLiEfxlYrsR1V1WvMlKQA2gmlayI=;
        b=R492jBKP2fpvlGY8fq+3L/OSSFmN52DBT+mYTgawpfy/+Uhaxzkf6JN/x4YpBm/XZt
         IO3DkidqSnstVBzR1+yfFvwLMe0aMrWtosintTaZSrlokPVSoR+FTeD1Iic3NkDf3HHq
         01dLEFBX8Nf23rxFEG+zHjs1AGgxoyDfipxE7b3vUsbNEbr8oZpVS4BUmkB3URXeyU/0
         GOZBxUsY9PiTf8sEjnBlPTyqYzZhZNBMN6LrwdyKonhJ91c33q6N+HdV3X7eV5zlJgK5
         7HRf2emy/reEZSfi0pfNW67XMV+acOHCmPaHhMVFNwObEK6Ld8cgHDsPnitigcsmfJTW
         /jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782398871; x=1783003671;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjX8t8yDdLY9x6HuLiEfxlYrsR1V1WvMlKQA2gmlayI=;
        b=RAA63ERN3mOp9dKuKkAEP7Hi/5bJozw+8fw3IzjhdwUefUeW/xuLQe4Z7P4Vjakl3k
         hnikgsdT/NqHoGzMdcrxKMgYhpCzrN008EnsajBBiJ2kZfvkyB2fMHBdjPdYJ1wdig33
         tds0VAN4cOUOAzxOrmG7H3o8u2OswKi+4+3lSyjKfTvxH0KeTIp97XSZBqfIxfaEsGGM
         bRKYa7bHYEOiQuAXwgW+3xCpLwlWTFrXi+jaF5V7Z+Ux9XsHN4p4s1H3xo27YnKqjr1/
         3je9ctCS3nBh4qaTxzpp3j6VmGKKGJevwfpnZz59cvt9rE5XeJlojMUS9y2ADvZu4QzS
         YymQ==
X-Gm-Message-State: AOJu0YyaRwNDxACKwcnu+CewoRCtHOTvAldnsH2CvtKbn5M2gQfw0Zt2
	ES+QKKTncnQWGuswexPt2aU5akuefVFxHQ3Q6X0vk3kVzw0UIoFdR1q6oYFZLfi2r08=
X-Gm-Gg: AfdE7cltsPBGm3eivZZTRtARZ34++aUd5y9bnSEQ4IBrWG3C7lRpFZioWHEFDOckEU+
	L++Fwym0QufbC3qGCv7KKnX21NnYBB7V/IMznS8FZctZ+b3R9dFI9wAp4Or/3HYXPHR/NoPkgZ2
	CuxjJYChyANVTMSI4LeWdR8NNba23kbGvylSBjgqpDN3Iug+bV/9pGR4WqIdYgmXnzkPiRaO667
	c+4fRlr0V5ycouTbpqEavuEmJ1xdn1mXST2cw54zU1RaL+xZseRb/pEzehvm/ZA0i0dGKzNB7iX
	lKr31XzQXhJMA5BuLo/OJtnyvGnfDAfn2n6/pOufJCEzJkYsONnNY7HpV4Uccm/odNTLNaU1NVl
	mp4KkNSyfhL4z+cqqDriVo1nYrnGa684lRDVVAKdfnKISGjQITm/rxPjQGlyySxB3NL8pGHoZ98
	eb/m5O9WXonK4QV5I=
X-Received: by 2002:a17:906:478a:b0:c11:2380:567f with SMTP id a640c23a62f3a-c1205eed845mr209369466b.26.1782398871232;
        Thu, 25 Jun 2026 07:47:51 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05ed6sm199678766b.30.2026.06.25.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:47:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,
  magnus.karlsson@intel.com,  stfomichev@gmail.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  tushar.vyavahare@intel.com,
  kerneljasonxing@gmail.com
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
In-Reply-To: <20260623091008.1046547-1-maciej.fijalkowski@intel.com> (Maciej
	Fijalkowski's message of "Tue, 23 Jun 2026 11:10:08 +0200")
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 25 Jun 2026 16:47:49 +0200
Message-ID: <87ik76y8ve.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301989-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30F486C6CB6

On Tue, Jun 23, 2026 at 11:10 AM +02, Maciej Fijalkowski wrote:
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx
> address generation. At the same time, the shared-UMEM Tx setup copies the
> Rx UMEM state into a Tx-local state object and resets base_addr and
> next_buffer before configuring the Tx socket.
>
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to
> the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test once
> the roles are switched: the same socket is then used for Rx validation, but
> received descriptors from the other logical UMEM half are checked against
> base_addr == 0. With the new UMEM bounds check, a valid address such as
> base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
> window.
>
> Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
> and Rx validation. Use the ifobject-local UMEM copy only for Tx descriptor
> address generation, preserving the BIDIRECTIONAL test's intent of using
> the proper logical UMEM half after the direction switch.
>
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk_socket_info")
> Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com
> ---
>  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index d8a1c0d40e5a..50a8dbacb63d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1169,8 +1169,8 @@ static int receive_pkts(struct test_spec *test)
>  static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
>  {
>  	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
> +	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem_real;
>  	struct pkt_stream *pkt_stream = xsk->pkt_stream;
> -	struct xsk_umem_info *umem = xsk->umem;
>  	bool use_poll = ifobject->use_poll;
>  	struct pollfd fds = { };
>  	int ret;

IIUC, this works because umem_real happens to point at shared/Tx UMEM
view (base_addr=0).

> @@ -1524,7 +1524,7 @@ static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobjec
>  	umem_tx->base_addr = 0;
>  	umem_tx->next_buffer = 0;
>  
> -	ret = xsk_configure(test, ifobject, umem_tx, true);
> +	ret = xsk_configure(test, ifobject, umem_rx, true);
>  	if (ret)
>  		return ret;
>  	ifobject->xsk = &ifobject->xsk_arr[0];

And this bit works because thread_common_ops_tx is only invoked in
shared test case.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

