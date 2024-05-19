Return-Path: <netdev+bounces-97123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D78C941C
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 10:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796BE2815F2
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E425779;
	Sun, 19 May 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="n3yfWri+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D610940
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716108307; cv=none; b=TpnqduTW34rMJgiAZG2kbeTzPU5KpUaRXASD/iJ0ltlSmJWjUJFwA04y+V0yDuAuxVDCuu2Ds7HoLvC7fIIFWu6MhV4jbSAbsLPIIfwBCDeG4T8itfMX00Iucf/p+2e59Cs0eNEO6RLkeku/AzvqtskfEvc2ZTVXl4k5FslWsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716108307; c=relaxed/simple;
	bh=URRzynUgCTaNBNed/DX/Uwf0PtAGBTI96lhj9H0F/rM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YpVbqCUb/goA1rNjVhZgFpDn09MiWx60q32tqK2yx2P7s2t9oOifcfsNg32kOkkDlplzt7LtUU6qPHxYBWdbIswKS2QLH8ujr+GRrRqDm77Xm1NBWk0SSw95B2YTVTW8KXrfFIpbii2/TFN/NW8URrUDN5Cv53wR4UOb/hcuRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=n3yfWri+; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s8c9x-00ASv7-QJ; Sun, 19 May 2024 10:44:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID;
	bh=E7z8mcCHLoRQfGUTmAhkyuguusteGXQX5REBZAjGYD4=; b=n3yfWri+TZJQkAQ+eNTZn1EZUG
	IK2VpR+kcDksJmBCJRJqCjsR0lUvQM0fEJXP9fimN99I1GdKhQMnJGOUijIjp8mNnVpPiKqm/z4pg
	IER1P7N8KgdSVq7zAGO2jp9VXF/Qte35nVieUpUKoE1JsNRaOZ82dabM0WvmaA/T/FtZen7byTiAm
	yVCXNtaKbm5QHmSeXQinrbFEReuTUogkD1SpgNTvi6t9k8cNYbzy917ufKKqOz7/5qFxFv2StniWX
	oMBw3j4nYnmZr6+AyhUKy3A2SUzMV7ejca+hOGZk2ZD3+xLumRVSPqwHbPpImZIS5PuVdd8avgwDb
	JAJ0C/PA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s8c9x-0002r1-2G; Sun, 19 May 2024 10:44:49 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s8c9s-00BSBm-Cn; Sun, 19 May 2024 10:44:44 +0200
Message-ID: <71ceafc1-269c-44e0-80f0-6f16a1f35f0b@rbox.co>
Date: Sun, 19 May 2024 10:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 2/2] selftest: af_unix: Make SCM_RIGHTS into OOB
 data.
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@amazon.com, shuah@kernel.org
References: <20240517093138.1436323-1-mhal@rbox.co>
 <20240517093138.1436323-3-mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240517093138.1436323-3-mhal@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/24 11:27, Michal Luczaj wrote:
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> scm_rights.c covers various test cases for inflight file descriptors
> and garbage collector for AF_UNIX sockets.
> 
> Currently, SCM_RIGHTS messages are sent with 3-bytes string, and it's
> not good for MSG_OOB cases, as SCM_RIGTS cmsg goes with the first 2-bytes,
> which is non-OOB data.
> 
> Let's send SCM_RIGHTS messages with 1-byte character to pack SCM_RIGHTS
> into OOB data.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  tools/testing/selftests/net/af_unix/scm_rights.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
> index bab606c9f1eb..2bfed46e0b19 100644
> --- a/tools/testing/selftests/net/af_unix/scm_rights.c
> +++ b/tools/testing/selftests/net/af_unix/scm_rights.c
> @@ -197,8 +197,8 @@ void __send_fd(struct __test_metadata *_metadata,
>  	       const FIXTURE_VARIANT(scm_rights) *variant,
>  	       int inflight, int receiver)
>  {
> -#define MSG "nop"
> -#define MSGLEN 3
> +#define MSG "x"
> +#define MSGLEN 1
>  	struct {
>  		struct cmsghdr cmsghdr;
>  		int fd[2];

As discussed in
https://lore.kernel.org/netdev/20240517122419.0c9a0539@kernel.org/ :

Signed-off-by: Michal Luczaj <mhal@rbox.co>


