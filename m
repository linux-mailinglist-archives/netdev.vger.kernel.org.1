Return-Path: <netdev+bounces-87620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F348A3DC1
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F2C2820F5
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644B282EE;
	Sat, 13 Apr 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbXifqc7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3117C9B
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026722; cv=none; b=KIhL36FJ55fgKP/gb9L8GFTlk0FLs7+1jdEAKskdgV1YjBdl3wDAA0c9QDEpqcaJSEyGA2jOos5OaM7CrGOQMRwKeKIesFuxqo0qg6Op3KLDjaPuUnRjm96akzH1khkjMnaUHfUJvHohicL7fuk9b084zhoeBlyzIeim0IlUmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026722; c=relaxed/simple;
	bh=PSejv3wYmsFleA1hJ0BcjHUG7LsWO1m7TNaYBaCINPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAIg2wMCuSdqZQ9TIL38w3EZfOXlnMocMGygwS+3xe+s8FC84D0ZA0nngzzU78i67UFileLknHOo96mWbr4QgSge3uhgXYt/bHwtMK4sv81D4mpQvoraXmIew/hrnJ7iVoL4pYanpN0Q3ZYbRcusJsXGA/nz3oBIO7nVh8EwBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbXifqc7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36b17eb28b1so699385ab.3
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713026719; x=1713631519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AWoi7AcWMFrM9AuKQoXehk+tHcCjKtQiu66Iwn+m2w=;
        b=MbXifqc7ISfPkPvFafTexjM7C1Kwy1n7S8tap9TnltmYHrAprXE1uU4BYakptUP2fj
         yQO1E9YoJC7egSnaaLz2ubzCjomsLlkvuA+/YBoqIUn4UvyIcJlJyfyygMfT40l9jEFY
         xFykWgQl15RAG7UiwRIFUbMGR6k1fPCSiQHunw4NgKV9H1KHngdtsi+yXIcr8j9/pINt
         2/rjEz12R3RrjD9X2mUqVl7HZ0vIw7cDT/9nQR9xiJKi+KSSomv4e9qD4cmwJe+IJXtC
         WmB3+76/H2oZUuSCQ6pYnu0csYLQCAUQCnkVqIJUkikyyw2N2ZpPRPmhOO4axzH423Et
         WWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713026719; x=1713631519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AWoi7AcWMFrM9AuKQoXehk+tHcCjKtQiu66Iwn+m2w=;
        b=ZGJqee6Bt3w1okNeyu7sm64qanYIiEu00c5sx/NqQrmJHw7QJY5Quyq6/3pP7sMVSs
         M9KXYR0lqqJ1TOpzavjX0SWBeJRm6/QF/ZmAHWqypI24z2HK6xOhbmBS4l2+cDiuhuuc
         d+gKO+ThHDJFCUtVKPHDkVl5QeGicUSQGgvD8P7f7QfXPRTH+lRGpO5OcqO7u9lbFHdX
         NDEy/eJX+O7eIGV9lNUBW/LvfsaAN/8nSgzBHG3/7AitfWFktO3pMMmNO1+EtJmDTpN7
         nIKhR3iHQu1YH9wR7JsXSm+NrPhUWYFA23ReSYweLlmvK5ChzjQWmbcIu5A5GDDJ0gUh
         GMAA==
X-Gm-Message-State: AOJu0YyLMbmUovmheNjPljnkEzzr53+LO+BP5DK3zzF6U5F0XvBccq2y
	/k3pRpwIQApDGDXiaEW8CPLIFSYrE8zsXjOgu7sYsu1Fu1SqNJI3
X-Google-Smtp-Source: AGHT+IEArR68JchitJk+iKq+CDG6LfBrmucdDPCF9/7R1BU3ZawZGdLkvQOpMdnIneKpjvAzObMwaw==
X-Received: by 2002:a05:6e02:1689:b0:36a:1e10:6820 with SMTP id f9-20020a056e02168900b0036a1e106820mr6687857ila.23.1713026719388;
        Sat, 13 Apr 2024 09:45:19 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:91c:ed53:dd92:4d73? ([2601:282:1e82:2350:91c:ed53:dd92:4d73])
        by smtp.googlemail.com with ESMTPSA id l17-20020a05663814d100b0047f1e195368sm1767578jak.136.2024.04.13.09.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 09:45:19 -0700 (PDT)
Message-ID: <69e00bd0-a1d7-4021-ada9-9d344e0e84e4@gmail.com>
Date: Sat, 13 Apr 2024 10:45:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ss: mptcp: print out last time counters
Content-Language: en-US
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Stephen Hemminger <stephen@networkplumber.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 2:19 AM, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <geliang@kernel.org>
> 
> Three new "last time" counters have been added to "struct mptcp_info":
> last_data_sent, last_data_recv and last_ack_recv. They have been added
> in commit 18d82cde7432 ("mptcp: add last time fields in mptcp_info") in
> net-next recently.
> 
> This patch prints out these new counters into mptcp_stats output in ss.
> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/uapi/linux/mptcp.h | 4 ++++
>  misc/ss.c                  | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index c2e6f3be..a0da2632 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h

uapi headers are synced using scripts, meaning at best uapi updates
should be a separate patch (the updates can also be omitted).

> @@ -56,6 +56,10 @@ struct mptcp_info {
>  	__u64	mptcpi_bytes_received;
>  	__u64	mptcpi_bytes_acked;
>  	__u8	mptcpi_subflows_total;
> +	__u8	reserved[3];
> +	__u32	mptcpi_last_data_sent;
> +	__u32	mptcpi_last_data_recv;
> +	__u32	mptcpi_last_ack_recv;
>  };
>  
>  /* MPTCP Reset reason codes, rfc8684 */
> diff --git a/misc/ss.c b/misc/ss.c
> index 87008d7c..81b813c1 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -3279,6 +3279,12 @@ static void mptcp_stats_print(struct mptcp_info *s)
>  		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
>  	if (s->mptcpi_subflows_total)
>  		out(" subflows_total:%u", s->mptcpi_subflows_total);
> +	if (s->mptcpi_last_data_sent)
> +		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
> +	if (s->mptcpi_last_data_recv)
> +		out(" last_data_recv:%u", s->mptcpi_last_data_recv);
> +	if (s->mptcpi_last_ack_recv)
> +		out(" last_ack_recv:%u", s->mptcpi_last_ack_recv);
>  }
>  

applied to iproute2-next


