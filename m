Return-Path: <netdev+bounces-210228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AFFB126FD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C14E7E79
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6422356BA;
	Fri, 25 Jul 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+sMIu9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355E255F5C
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753483819; cv=none; b=N/+d2IrZ0GGW/iWaxIKwr0P+OtydsC+YixjzUZ5GMMq59PXzhfObq221TLlz77AwcvoGThEvIkICoI3orUDJqa4btaMRPxK0BMa35mR2xUahqDHgLif14xLteM4t6SwmPczDymRLHpC37BjV0TjZSWuWOps/mqeYF9oUzdw6jYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753483819; c=relaxed/simple;
	bh=26GScWCg2K29yMyhSSRBrYqyXcQ1VJR/Lkp3xmodU7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czCzoyAhfT4BxrAMpB6gxzQN02/HYsq3xZf39tV0gv3NgfXIgIJwwxfcxS+RdsgAu5TY3H06mjJPahkCit+0Bjqkz6W8s8XPDBuMEkC2WugBeDKPZZnzvhvmslvWO47PSpkC3DgEz7xHlOjsrpwJ6T7P1ywB+bZppNxl+++XWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+sMIu9q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747e41d5469so2970306b3a.3
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753483816; x=1754088616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiSP6KLGisH8fARNwKMDQIWzBUaDFJxS95nlRQSwIao=;
        b=M+sMIu9qQ2cA2AxpqEH521xTNSuLVAj+imrIcxfLiolD/M/K2Wq1ibu4RH3qLKVYZg
         ugNVzNLCb+H+70BjSJZrTM2xJ6MUhJE9F/lIsNTknBqmHxergN3tZq/45bfVwTy3he+E
         6gBE8tc7OjS7YvhkjBNJE7Eo0peLcTff3SuNvqmC4NKLp/Tb5+ovAhKuQIxredl1Z6sF
         /FosdOrDv4ehW5EKby0qtAKgnfqa82dQrTKon72VJNITmjaCB93M9UKDi6VUoo2CKjue
         AcXSqcvbM3r5d99+L5YE9/9zhHAqCaWOT6sI8aNKLGjhOcTBOtqtA8PYp9QBz8bjrgdg
         stJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753483816; x=1754088616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiSP6KLGisH8fARNwKMDQIWzBUaDFJxS95nlRQSwIao=;
        b=TUe8NYwTizY+9vlGj1el9aNs6YSeyj2S1sahOV5e8mjdINnU3Lsl3M4MxsJc2TqVOK
         WY0O6wf/tK3/pC9B8ZLdLZkD+OvuklmFhOdNKydr26J2Je9KEj5CfdPAMO8BLxiCfF7F
         4Q23r4a6fu+sSxDEvYspv6OoGEtPSeWN5m3I2K53+TugDBp4e5ovhFhjWOgLJtlIlYkE
         VCJmgqh6xSQNyZ8p9OaZCLxdR2DDOvJYoOFJjdfzeKn/eRnBa+AD4q/v0ZhfJLPK2Yxl
         IWy6kQXwppW3CCxZcZX2pTwXWsvMM8rw+Vg0cpOH4Gt7w/2iyUTUgawm/2dpCLU/2Qze
         EMLg==
X-Gm-Message-State: AOJu0Yyp9AYx41NCfutIc31GgOsCmPxXOpr3HQOHVqyoZtpgeXTY6TZE
	7VM0Fcvx+kkPDxkK2BTXa5Y9c8Vx8DQ0ncXYtEgb4S+RW7ndY7jeUm/+
X-Gm-Gg: ASbGnctscdtA+y4j4vN1F5cy8J6fczgAr1+olg9cJLmzpK0lD0SkdIiIRWHjnogcANQ
	Xo2aCUGfItcKiULum0a7smLZJkwhxEt+c4XbyXy1+y9XquGGVbcCtpDSF89jCVq7yuKNHvpFizo
	b88frYR2MIuCxZ8tIZgsola73XL+t/ovb3W3FHr+VoJEJjuliOQroETpKNDWWq7hNUSfEDhq9qe
	90E2lxmlolTxZzd4V/zOHWO/7RvWCq4/NKRtD2eXIEH1hqOUvfeB+cocl5jDkYT8uKo0phO3P/0
	cIWs44HuEvK+FB/TCGHCIzLS/eCa3kA0xDlb1INSPvQj9UR6RTnUt+DuXbPUDsJXrlZSuLZ2YRW
	wdFSN+QqIu9KfbKvLdhvB6dXkzso8JUhCq1HX
X-Google-Smtp-Source: AGHT+IGJf4w0SUBvZvOGkgeRG3upUi6ncTBAY8PkVjmQU+bZq+ZOSf6EXiwqIxtVCu8rd/enSQhbjA==
X-Received: by 2002:aa7:8882:0:b0:756:a033:596e with SMTP id d2e1a72fcca58-76337aed06bmr5988467b3a.22.1753483815930;
        Fri, 25 Jul 2025 15:50:15 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640ad066acsm470607b3a.65.2025.07.25.15.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 15:50:15 -0700 (PDT)
Date: Fri, 25 Jul 2025 15:50:14 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io
Subject: Re: [PATCH net v2 2/2] selftests/tc-testing: Check backlog stats in
 gso_skb case
Message-ID: <aIQKJlbq61svuSoy@pop-os.localdomain>
References: <20250724165507.20789-1-will@willsroot.io>
 <20250724165530.20862-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724165530.20862-1-will@willsroot.io>

On Thu, Jul 24, 2025 at 04:55:53PM +0000, William Liu wrote:
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> index c6db7fa94f55..867654a31a95 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> @@ -185,6 +185,207 @@
>              "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
>          ]
>      },
> +    {
> +        "id": "34c0",
> +        "name": "Test TBF with HHF Backlog Accounting in gso_skb case",
> +        "category": [
> +            "qdisc",
> +            "tbf",
> +            "hhf"
> +        ],
> +        "plugins": {
> +            "requires": [
> +                "nsPlugin",
> +                "scapyPlugin"

scapyPlugin is not required unless you generate traffic with scapy
instead of ping.


> +            ]
> +        },
> +        "setup": [
> +            "$IP link set dev $DUMMY up || true",
> +            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
> +            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 100b latency 100ms",
> +            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 hhf limit 1000",
> +            [
> +                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
> +                1

What is this magic number here? :)


Thanks.

