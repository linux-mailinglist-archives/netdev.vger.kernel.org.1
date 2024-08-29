Return-Path: <netdev+bounces-123307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0E9647BE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B5E280FCC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF819005B;
	Thu, 29 Aug 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDO2DE/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305AF19408D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940969; cv=none; b=AR2xrGmhGvyQFaLly+REiKm7OYn/Ix/HnsSUbgZT3GpNQXHF2+JmL5Pl47uk7TDq31ITTiT3Z9bkE20M9EAW6LSX7JoQJaFsjMLH6GgTy18Kd53NIB5S2XSpv7jtojJYB7MTSpqGIsPJ6UDUMx66BRc3Pi9BKDaigrFkWE5t0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940969; c=relaxed/simple;
	bh=ywf+8W/FG1FuD2ppVyGZRMgUVcCto9o1HzWxFQ18ETs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DZ0k4SLykNr82uud7SRdWbUNoLgFEh/uKGFX7KMXZQb7xCxDDF4u3f+j1eF7FDB1RQD7wtx8SYGX3YWWLog2q9EcZttG9bu4shzVtUyPMEon55VYS5wXnEguMnAViGALwGSmREMmLUkaeBnSzIrVp93Atug+7soIqvYCcxgFO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDO2DE/N; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4567587224eso3987751cf.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724940967; x=1725545767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjG69WwFX5tVs+S+deg2EppKgm0ohgOtGitckoFll2o=;
        b=SDO2DE/NvIO+PwWSnamwR8KINTBTCme3qCDo6Z8pQKffTKpIGrAgWX34l6D0kDGjM1
         r+y/6Qs8utfQxdMBky+x90juWQWAIBXn5ZhIzH7Z8POO5RrYkamXIj0qitNRa68IJtdx
         0by3ettrzltWivEjZ17bYAqTj6H/NaCwZNPxY+xzJewo9Q+CPNX0nWLnQhAnDUocK8QS
         jCNB20OcWhyGrttf+OOOsIM/5oTy9MXlNqf3M22lNL8YSEDmrPxVOvCXPTDp9QRaWsQJ
         V+hKGyyimDdp1nK/o3MF3+p6tLkc0mKRw+x1kSMVHOFHFhp41lmnxQju9/+ZogC/JRXe
         66zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724940967; x=1725545767;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qjG69WwFX5tVs+S+deg2EppKgm0ohgOtGitckoFll2o=;
        b=V/0E9eRVEhdeNwaadfuxWxsY4Uq+iivJGMexqrOeRmSxPsmo8t1iocdeSxJrWdWnlu
         FCybkxxhoJR3RzGuNzlNojjmdzntEr5jjf/UtkDzt1BeWNYfigk+GTKxRbwKLBdLBcF1
         mfMwtBo5oPUazGY+3dyiGcy7/R+WJTbB7DOnMjKl1IEXSXUCZ5ZFQ6gEp05VMxBo8vY0
         nZbXpFLebpmbfKaqbkJeDf8Ps72RE7IpRkX6kxyXF8hlWAZbb/i8vv1f/AMhPK4dTq3O
         MIs/NgfHy42afD6OUAjQnh8B2OTT9sGT/pt0IHRn5fpoYKmpgMet+ad+d+MG7uQIy1qt
         Xslw==
X-Gm-Message-State: AOJu0YxORYdRGO3cBAAgE+5Bx4uMeynfkzS1haiWvyFSwZgqKjihROaW
	GM0yGIAtNzGM3ljvsneI76UXCAG2j+MwpPdWiD6zENd46v0f5Yqq
X-Google-Smtp-Source: AGHT+IGQgyLVnUHZHkrcPvKUuNHTNYj1tMGgp8kYqZeSj/Q8TpUnJk7mQB8jeBTBzc9Y+R0On6KNGA==
X-Received: by 2002:a05:622a:8cb:b0:446:4cc5:523d with SMTP id d75a77b69052e-4567f50e544mr31323031cf.20.1724940966779;
        Thu, 29 Aug 2024 07:16:06 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682cb02casm5140141cf.42.2024.08.29.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:16:05 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:16:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <66d082a58cc98_3895fa294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240828160145.68805-2-kerneljasonxing@gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <20240828160145.68805-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Normally, if we want to record and print the rx timestamp after
> tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE
> and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can notice
> through running rxtimestamp binary in selftests (see testcase 7).
> 
> However, there is one particular case that fails the selftests with
> "./rxtimestamp: Expected swtstamp to not be set." error printing in
> testcase 6.
> 
> How does it happen? When we keep running a thread starting a socket
> and set SOF_TIMESTAMPING_RX_SOFTWARE option first, then running
> ./rxtimestamp, it will fail. The reason is the former thread
> switching on netstamp_needed_key that makes the feature global,
> every skb going through netif_receive_skb_list_internal() function
> will get a current timestamp in net_timestamp_check(). So the skb
> will have timestamp regardless of whether its socket option has
> SOF_TIMESTAMPING_RX_SOFTWARE or not.
> 
> After this patch, we can pass the selftest and control each socket
> as we want when using rx timestamp feature.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8514257f4ecd..5e88c765b9a1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>  			struct scm_timestamping_internal *tss)
>  {
>  	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> +	u32 tsflags = READ_ONCE(sk->sk_tsflags);
>  	bool has_timestamping = false;
>  
>  	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> @@ -2274,14 +2275,20 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>  			}
>  		}
>  
> -		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
> +		/* We have to use the generation flag here to test if we
> +		 * allow the corresponding application to receive the rx
> +		 * timestamp. Only using report flag does not hold for
> +		 * receive timestamping case.
> +		 */

Nit: what does "does not hold" mean here? I don't think a casual reader
will be able to parse this comment and understand it.

Perhaps something along the lines of

"Test both reporting and generation flag, to filter out false
positives where the process asked only for tx software timestamps and
another process enabled receive software timestamp generation."

> +		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +		    tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
>  			has_timestamping = true;
>  		else
>  			tss->ts[0] = (struct timespec64) {0};
>  	}
>  
>  	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
> -		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
> +		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
>  			has_timestamping = true;
>  		else
>  			tss->ts[2] = (struct timespec64) {0};
> -- 
> 2.37.3
> 



