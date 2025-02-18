Return-Path: <netdev+bounces-167329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0682A39C8E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC563A527E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17D26138A;
	Tue, 18 Feb 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLfjMyzu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2E25A35C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883202; cv=none; b=N/CAqaJhYC5csbSDBVLQWhLQlljb7GovtVIXSgFw/5fpSY82wg6uA10O2BAu7tivqqrfeOXdyo3fQndG1/6okylbvTa9RLiNsD8R4z4I1iHf5hoKMNrECC0eXkxo/WJKGEH+86xx4S8oCh88XeX7ZDXF9Q96s81Zjno/8vMZd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883202; c=relaxed/simple;
	bh=B6rcI33jR0AkhpRZXIBj9cKrGXC+Z78I+ZFwTdFFfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snOeQTU1epxlqeuOUUcJ33VytD7SiqPp4kH31jbfzuSHboWi1uTBifBeg6f4GMxz6pCZa5wqwKi9hYA35zlpmlWRnvDnIwh5mquuvODTkd6kUV36HUPDKMpq7CoPFObzgEhifYZU1txrDNeA59bK+VCUYXYnd9cvzBZbNPKmX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLfjMyzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739883200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsfKFHU32JDYtPZqdtJcI1xvfyN6A84vuhKqOKdqLYQ=;
	b=bLfjMyzupBokMg6T0V531JCTQy8yJ1D/BgzB1u1XWgn5PDVtq/5ze5kMeaGJ6MKXy8ZZvW
	8gA2chY4xOcTgpGe3hjAuv8ULtLzH2gPY1vt6UtRkvCovxEweQ6GNe5DYCMWVYNXH815mj
	N8IU79g/kaKIXCCec4mY76Wpb8E7J5k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-dCPsb_scPFKSlgr0XeA2lA-1; Tue, 18 Feb 2025 07:53:18 -0500
X-MC-Unique: dCPsb_scPFKSlgr0XeA2lA-1
X-Mimecast-MFC-AGG-ID: dCPsb_scPFKSlgr0XeA2lA_1739883197
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2cefb154so3515686f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883197; x=1740487997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsfKFHU32JDYtPZqdtJcI1xvfyN6A84vuhKqOKdqLYQ=;
        b=Y/G+eARXEPiqqRywdskEGcOjdBzFvV/l+uSJwevaB6efaoGro04WB93ltpz25cooVM
         JEcmXUmfOwFIowZ1GSdHfh2XC7Hq2jVcD8fb11j3UCg5zoRZoTABDEDQE3e4WZIL6W/6
         D0S/Cf5vqATbcx97XMT0pUfasgURoRyJQfed3xtPb5pPwtVp0KybsQvWOFw4UUseJg6T
         oJRDdosoip5B1dUWerCGC6Eyci5y6Y2DexJmqDvrR1GGpHxzU1czXHPQsiV11kddfKHt
         L93xRJEYMAjEXEBs6KVbabjv/COlgRVJRcNwb4lRLu/3Us1x8FQDDURthrRq1EUUgTL1
         CJGA==
X-Gm-Message-State: AOJu0Ywe3+IfNFNT22gUEucbod2lT0dOk78oGgzMYwsuyWqiK/Yzn1Iv
	Fyr3zqIz+Qe8eSaLa8Sn2EIi3Ic7bndLuL9j6DLbRJ0MxrWbPij81M6apGN/+AM/Qg9ZLn2Lhda
	Uzp2hE4qrOjPoOb3eovjqJHYBcKyf2GhVRo/PHBolX3lboLSd4392EQ==
X-Gm-Gg: ASbGncuwhVvQ59D/6yEs0D9kgWH1JoHZnKwF966+52LgFJSOO+T4sFaWdbrrQ9dgEgk
	pq8YygaX1CfJlMZ3WOkmpBdpitmu5pGKbaXuk1qg8Du1DfNiE3cIHBT0GsG5bR8CCCcvHF1CiBA
	IIWgCjKga3jRgr19Lt7W2H+P+xrO1r83tMUmzaqxWmcncFfe0t5dHylJ3Fg/6WqVXHrOwUwTXZf
	n41o3GbbduiAlTuENfInDKTYtk/P2mPKWg6vts84OKqCV+SjVvIiTMaEDGD3aATs5mh/W2iQ2xl
	vusaFVr62eQ+ZwgMjBCX+FYEZWfpcnW0juA=
X-Received: by 2002:a5d:564d:0:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f33f28c73mr9321376f8f.18.1739883197494;
        Tue, 18 Feb 2025 04:53:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmuOBQoBPGkm0apcXujpsKNRJknLqhiWdlArj2xmAH10Rv73rZHl5OqE/4YMT5tnZCWC0Bzw==
X-Received: by 2002:a5d:564d:0:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f33f28c73mr9321354f8f.18.1739883197088;
        Tue, 18 Feb 2025 04:53:17 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm15132973f8f.32.2025.02.18.04.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:53:16 -0800 (PST)
Message-ID: <cc84f98f-d3d6-499e-9d2f-47eaeb56aad3@redhat.com>
Date: Tue, 18 Feb 2025 13:53:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Ahern <dsahern@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/14/25 6:07 PM, Breno Leitao wrote:
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
> 
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
> 
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
> 
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
> 
> 	rawtracepoint:tcp_cwnd_reduction_tp {
> 		....
> 	}
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> ---
> Changes in v2:
> - Close the parenthesis in a new line to honor the tcp.h format (Jakub).
> - Add the bpftrace example in the commit message (Jakub)
> - Link to v1: https://lore.kernel.org/r/20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org

For future similar situations, note that it's expected to carry-on the
tag already collected in the previous versions, since the delta is only
cosmetic.

No further actions required on your side.

Cheers,

Paolo


