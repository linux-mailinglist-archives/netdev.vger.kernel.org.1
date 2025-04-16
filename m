Return-Path: <netdev+bounces-183202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5CA8B5B1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B616768A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1768C22A4FC;
	Wed, 16 Apr 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htkN289m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F522D4E0
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796381; cv=none; b=Q21uJnl/c1AbU2lvZoO+DY9ryKKQn6/ooujdKBJvYofqpx/s7WnvxdxdonvAtyFhBHzyWlaGThKzHhJqYxiTCLWH8dOvDdu5Y/DuwPrJF/bMF6A7NigGpG7KYGzPTtPq/Iqrt7KW71aTlnpnQnawJuM4Qa0JnGU+kz2T4WR8DJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796381; c=relaxed/simple;
	bh=IkKJs+24eXwHdjJtxTjgs/wA1D4Z/lRJ8nAFzMHgBOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qStJ4m+Z8WPqGH7nO/hBi06io2Olam6Ftcz1Vh5jdGKO4Mfo/tF9r09lOVuzmE5QX7ykqmc5B8bzqGLVMVwDS3PpGLx9KbU/E2dDVA3Hi3Nlf+5zRapgQMQBy1uCFpjFNKZoOK6RUXlV3/WzFG/JfVsJh4KY1XuCItKuV7CmJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htkN289m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744796378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP9mxZwKGXsdHsD6mjK2u55573fmzs+X217QV3TlObw=;
	b=htkN289mOJX4i34w11d0S18Tn0l3JRexucVS3y4lSxC1VDmkfRypEA3WtUmiCRtQZLZD1e
	0eiMyy7Hhg3o9pBH757ME9GUcI7gR3x4D2wtra0SGwF0QTAkFCehWpp4HZUtStmX2HbbpG
	thLEN13j/PRKTq3iKKScROp1eY31CFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-NljhYwBENd-uO_x8u1mwWg-1; Wed, 16 Apr 2025 05:39:36 -0400
X-MC-Unique: NljhYwBENd-uO_x8u1mwWg-1
X-Mimecast-MFC-AGG-ID: NljhYwBENd-uO_x8u1mwWg_1744796375
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39135d31ca4so301574f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796375; x=1745401175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fP9mxZwKGXsdHsD6mjK2u55573fmzs+X217QV3TlObw=;
        b=DLC8EXE8L9xtGtwCc/qFYZhEB1vMxNph04vFGPEv55dPmIfWcGtxAtdPBUWLppb1vF
         8hh2Y5KyK3LHKp2hTEQhvH51MFXWKGsmBShSknl4FgZcosfvkBgqK7+Ov5cSpQ13Wnke
         eySQJh+7q372on61wBP2vWWAxNApq5e5GqHX0yk1bQVh5Lym7G+53yHCXdTKi7m1ORiq
         u0zhHf6Og2V5qA1QTjvJ06KF3vDmwNwJih7SWlwXEzM+S7KYlh0I2QsiLPEl2pvMAt+4
         ywMVGX44QIoRY+2czeW3w4ecAeAlcn86rKhj/pQQAtRvT3JBYfxmT1fCWT8UZt/imZwE
         bwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS9MmdJgZiiMsGq200KuTmZXz8vHBaqgjQ5kfybOdUUSpECBPM4NUcSSg4lhV8YNODcMRcOqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLE5aYHIp3Zdf/MoBiBOBR0m5xAwOY6bRcfdvXI+1fZtg8sdn
	81s89zDWIpXIEEEATWYRsY2OYXFe87FzNSezrXtytVqvE0S/nzTwYiDp7NORdSF6kuD7WAZJNql
	9FA6/ZqvVfJvQGNIp4dFKxpIvQ33kiM8W4OI/eFhoLiym9IkPx/bQgiq/sV0RyA==
X-Gm-Gg: ASbGncvqvM9DTr3xAj/LzT8dMXeCU+L1WiGYyEQiysMSIKgrOaYAVULMmZixBSfPvvP
	OpsM+LwtvXT4JbPk6jYJFIJv/P1uwjEUk+x1Qq1CIRssMXxxNeCgbpq/02mHDsZ2LJVQJ9yIud0
	atjUb6MR2Ov2uHQ/KNAST2E2muW5hdwhkwFl2+6v/24+kO+NjHR286MP/YBKtbhO98rA9+Rfj2Q
	hnSTVm6PPBioVofKES3parQcD/Sv60Yz8W21V321cVAv/Zb2/dxxK1uHkDWvovhzSGMscgzjqEZ
	zuSldXgqAxoiBT8x8EnB7/eWPLWzCJcRETKXtMY=
X-Received: by 2002:a05:6000:402c:b0:391:386d:5971 with SMTP id ffacd0b85a97d-39ee5ea44a4mr1021612f8f.14.1744796374964;
        Wed, 16 Apr 2025 02:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUUYzuw5FRm1JeOXHzwQ1h0IFeIpyJSyHmTW9re5NqkvM4FC+BMZHgBQnDJdfpTZRIlmd2wA==
X-Received: by 2002:a05:6000:402c:b0:391:386d:5971 with SMTP id ffacd0b85a97d-39ee5ea44a4mr1021600f8f.14.1744796374672;
        Wed, 16 Apr 2025 02:39:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640bcsm16516100f8f.1.2025.04.16.02.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:39:34 -0700 (PDT)
Message-ID: <50398406-eaa0-44c4-8eca-373bbaa6a8c5@redhat.com>
Date: Wed, 16 Apr 2025 11:39:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 09/14] ipv6: Don't pass net to
 ip6_route_info_append().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-10-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-10-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> net is not used in ip6_route_info_append() after commit 36f19d5b4f99
> ("net/ipv6: Remove extra call to ip6_convert_metrics for multipath case").
> 
> Let's remove the argument.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


