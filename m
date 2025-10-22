Return-Path: <netdev+bounces-231656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8176BFC267
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACE66E0A07
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782C347BB4;
	Wed, 22 Oct 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GolNBY6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F4347BA9
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138132; cv=none; b=S7FOqddMHlxLruwroKhVKYzG6n8Byrrt/JBnY/SoLJTBxkOT4G4gnqt9RqCwqI5OsdDaZgcgazsWswC9/1s/4YzGuZBK+Vw2XiRFyG2aUT21gAhlcggI2be0SmPAeLQhJtGwZnlpH/jdfWqTSCjV7HvV0yHbHYnnRH0REcC5XMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138132; c=relaxed/simple;
	bh=J4bzJ23ONa1cJ6MhJY2CDuBayp00O+xQJEqCe6UxO9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8cAsx2D8LDAfYzJs/frMCCF2WOHAHeynA2CMIkW+Djf/McEYS1rWuSG5BYjMohRfYQRXnTnREce1+STJP0rol/VKh6VYIcbpNkNTLoieTt7sUTh5bReqLAURhAWHuha6NbTD2Vk/t8gihEZrAE5R/9/eaQfMuTYSWnITy8XcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GolNBY6i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso10295613a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761138129; x=1761742929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNgKKD/T+Yc6OYPm+3YKTinvWNdIUbP6kbhFhE9V8vs=;
        b=GolNBY6iigj9F0H/6ZiNxWrem547hs2RV++Ngqddy0UsKPYkN+DI1O/Yev7iC5BfEV
         kQG4tbUWVDH44eUIUu0+Jc8vUFkgzdRI03bpQEOE22wCqZuHbUg+GYhcN2oR9Uj2mdiM
         GW0kDy7uHQAVUSYMgEdftsEYQRNgR1izHXn08etgPxOP4BG6PJQso3QXRa6Jf0wc79R3
         tVkXZNW0SkpA9C56QSTIiiguvS5INUpTB7d6Tbz12YqipJtqyVng/kN5cMSxa2QfBYXA
         mCj++6DPkPu0+dOoU+G0FGzRwDlVkGP13U6gOob4nK8cnqtPzEZsy7mhygVRsREjs3B9
         vvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138129; x=1761742929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNgKKD/T+Yc6OYPm+3YKTinvWNdIUbP6kbhFhE9V8vs=;
        b=h/qv+kvWwb6PsANvNDV07To57hUdGJMtjijkQiqw4u18f6UUCru5xOwbrPTz8iBQ+V
         lkoIoyuy7crBJUFOem6fSfkRP1BXzLd3TC9GZAJscyU5hyvyeYb6iKrXIWs/++xlJsIz
         4AFpZTBMkKc15lIQTrJrqGtZJcIxZYh/Ogro7YrYqdD99sIDFYqpc6I0JHBqcex161PX
         jgWS6gvtA7tOcUWsGUEQl/VAhCYHAxka9mnPuBnnnTCdhVpc3pj7+r09rC0simocq1Ik
         vkpJ0KdSPoEvZVWuAjME1dAx2FlAYsKH567Zk3NllPkNVTlq8ARotEzPIrz1q21/2D66
         dvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuxSk5uoOxlFo8TgsShTYciap2uJzP09AbGiallkfasWyzbKlRF+iEPWBdeJiDU91dB06PwN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwysS6le/ey8fNL94paih/87iwAg1nh0QrnX5VaLqc8kP2Ra2gd
	6B9BxGWpMa5e/JghAyapaBV0FGVohOhPONzlDtAk85Ln6KJicuyl/W5uFEyWgpL9fQw=
X-Gm-Gg: ASbGncvRva3cSYuWjS0sXbAbPkJxnarE4SaeE4L6SCFfaQSaQObgqpL0kcgvsBanWoC
	8/asFufOZ4BPJDMou0ILZfGTemt7IQpGHBXZAYA/AHzpTH4A/qTdaW9jX5D1pAFC+6rvNQcg1Vi
	9fJ/lWis4A0idb9pmKyU6IoGJDDdEz/C0KfVgZbZeh/76ZHY+3rHXsqvAM+zP7yUgPgHEE17Zag
	tv4Iyrnz16Ak1jWQyENPFODRiiUq1j1iwAw3e6A1yhGCDFxkV49ofNtzGj5epSQLBfuLt6VY3kU
	I5Wygcv9sV0zIoiAluisag/FJFW2Q8cqllVH4xS9zzCcd5ydYcwRohrW71ZU1QcJl5zHQjP/YZR
	11h7lCvzhhtQQR/KVsGFhQ8/f+0xswiburTFRtQH8aqly7FDEreJJrzKHhPNGfLnlDwOS8BGQRR
	pZYCXCv1IXJt7LLwRPswaf02KLWTRYJndN0uZfy8k6b14=
X-Google-Smtp-Source: AGHT+IEmDf3z7baqtJNOanSoKJrBR4id4w5eO7NfPmBVAbnBWFCXxiHXsuxzHw5uOJtjJe4KS3Ch+g==
X-Received: by 2002:a05:6402:210d:b0:63e:1e6a:5a88 with SMTP id 4fb4d7f45d1cf-63e1e6a5f89mr2575448a12.24.1761138128754;
        Wed, 22 Oct 2025 06:02:08 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm11854405a12.41.2025.10.22.06.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:02:08 -0700 (PDT)
Message-ID: <8371b864-33f3-418c-aa5a-d1c4cfaba78e@blackwall.org>
Date: Wed, 22 Oct 2025 16:02:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/15] netkit: Document fast vs slowpath
 members via macros
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-13-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-13-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Instead of a comment, just use two cachline groups to document the intent
> for members often accessed in fast or slow path.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netkit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index e3a2445d83fc..96734828bfb8 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -16,18 +16,20 @@
>  #define DRV_NAME "netkit"
>  
>  struct netkit {
> -	/* Needed in fast-path */
> +	__cacheline_group_begin(netkit_fastpath);
>  	struct net_device __rcu *peer;
>  	struct bpf_mprog_entry __rcu *active;
>  	enum netkit_action policy;
>  	enum netkit_scrub scrub;
>  	struct bpf_mprog_bundle	bundle;
> +	__cacheline_group_end(netkit_fastpath);
>  
> -	/* Needed in slow-path */
> +	__cacheline_group_begin(netkit_slowpath);
>  	enum netkit_mode mode;
>  	enum netkit_pairing pair;
>  	bool primary;
>  	u32 headroom;
> +	__cacheline_group_end(netkit_slowpath);
>  };
>  
>  struct netkit_link {

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


