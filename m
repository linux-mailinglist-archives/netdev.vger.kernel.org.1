Return-Path: <netdev+bounces-147298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372749D8F79
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 01:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A8A1641DA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980A161;
	Tue, 26 Nov 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qV+rCpnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F3A41
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579949; cv=none; b=Pr2YuUMLNHfFrgbPewGFx8BATXqN4W/qIAP6LEiVAsuLzPj5rE7XmNQ0cxxPmFTEVBnHp457p1KV0DTQFp5fiZrvfLKutLH0/zriIAQS9PM4rj//HcWgulBy7GXtxXyzjBE3a+jT0EijYIH/PRPghgpgSDLqRx88+ExURFAGags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579949; c=relaxed/simple;
	bh=o+vtnqHmxi1PuczgzkKL6wJ9wctkZxf2RkQAuU/SzXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCufkqxqbNPfAhkMCKDG8Q8rH747ebMZKEVpQUCHaWWLM/9F1UoIyzTcZwTuUaV/6+yjdSWNzHoWC8ZQ4bk0qHSgrb+kzbefyRnakGN9mkHORLHvksuAQQs8VfDALUmciJ6PIDuJguHarKYD3DQTeJFsBhXloNU1BV0xhQPBaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qV+rCpnF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21271dc4084so46488825ad.2
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 16:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1732579945; x=1733184745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlROVXeKJggSsiOL2nTa5KbjilhiJMuoHam6FHLloVk=;
        b=qV+rCpnFftbRxySmjGCtsJaLuPFWj93iyE2EXjnggkGb6+Zf/2e/SQ3r812X1ZNblJ
         yXeWXaOTmoWGftSdgsB2sJX9sIAj5/cM+HpHj9z9BCIQzad0NrqT0apLUFsnTswAmbA3
         JuPRVvl4zmW7YT4vx6/QyFhJh/q2+ctWYz6guy0egORCdlzUMajFNAolThIFTgtMmZI+
         lIjEdtNarAUImjptCJDNMD3Toa7JyZhGVsAkx6cPTEIRKxUq21aso74kNg96Y+A/axnB
         aVXy8mSGUowbBySChShbetSwJl6y3+kLaIJ5h5/c22n8xDqFvY5zerhaedtuQE/r6vHu
         Wg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579945; x=1733184745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlROVXeKJggSsiOL2nTa5KbjilhiJMuoHam6FHLloVk=;
        b=V7pvFUKpuZ2Uq8+m1WJ4OzRuUlWxpinOhrSrwmOJOIDEB/pe5d9ZJePPugjZcvBhb5
         JuV5MnVPVwuFqvgKHUjQpvqklsRcJFwWGv9rZue6lCoq7OTAy/qko9mZEsLciC+u6MTg
         GF2yqfpSZ5DuW6VKTyCORn6bPXZem2aEQWI+Xkunkxz+lNs0MQEzx+ApmKYe4/P8xyXs
         9t0hOEumxP5o+eP37GbnaGWDiujbPIrVcGy/FFAA6W7x5Ds+ZWgswOqH0D1KL5HetZnH
         NcZkTOuUiFb0qvc6Z06UHWs9yHdjlLG3q19jC5ol1xW/C/+OvjRi8F59VL9qjxSHktiG
         6o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxxn/E3mEyzb2UhAh3UyRCu6T6y2yZXRKgBiaJ15kn20RsUhHi1QPPdbE+5DorPPPT7r5asxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ykwH8Vhxf4CGVeCRLSzexe9TKy/prPIaeCBaYLf6mFPRZW7n
	Ht25uZtChImLME4nDgZinZ7z+zdyxaGN5wLezhoDQ4ajFwaEx8wvUdvtfs4cVqE=
X-Gm-Gg: ASbGnctlCKYBHM88xwoKKlKDSB0Qh6yITAMNE+lrKhlI7mRYrMT7bLtSzMPampomVyq
	rodqkfI88RHhUL4yhEUuJhTP4ONpDQiJocLbpsGh1TleP4B5Yiwer9jh4gvYBpIQ0/RFZ67Tl5g
	FE00wl9DX8fiy0g5zq0HcmWbyksgJd+fdsH9791lXIPvfzcAEHV9qk3VNkLW7I+SiTDqw6vf3dz
	8CibVHbn+svvgWmQaincGGt13ffWsjERUBZq0cgvRajWtl8wj20zmT0+Tah5b7BZF2yLG/G7tEz
	+5JMdwKJ1eTFcMFJnC1hq5SWEys=
X-Google-Smtp-Source: AGHT+IHlJxV4EHN5x1t4LJyxjGZEQOU5XNBfiSIOPzucY0fLv6kHUuS2OnUFp2cMVFv0rw1ibwtD1Q==
X-Received: by 2002:a17:902:f54a:b0:212:fa3:f61e with SMTP id d9443c01a7336-2129f5d81b8mr222608855ad.15.1732579945455;
        Mon, 25 Nov 2024 16:12:25 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5d4bsm71559815ad.80.2024.11.25.16.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 16:12:25 -0800 (PST)
Date: Mon, 25 Nov 2024 16:12:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Martin Ottens <martin.ottens@fau.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] net/sched: netem: account for backlog updates from
 child qdisc
Message-ID: <20241125161222.40448603@hermes.local>
In-Reply-To: <20241125231825.2586179-1-martin.ottens@fau.de>
References: <20241125231825.2586179-1-martin.ottens@fau.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 00:18:25 +0100
Martin Ottens <martin.ottens@fau.de> wrote:

> When netem is used with a child qdisc, the child qdisc can use
> 'qdisc_tree_reduce_backlog' to inform its parent, netem, about created or
> dropped SKBs. This function updates 'qlen' and the backlog statistics of
> netem, but netem does not account for changes made by a child qdisc. If a
> child qdisc creates new SKBs during enqueue and informs its parent about
> this, netem's 'qlen' value is increased. When netem dequeues the newly
> created SKBs from the child, the 'qlen' in netem is not updated. If 'qlen'
> reaches the configured limit, the enqueue function stops working, even
> though the tfifo is not full.
> 
> Reproduce the bug:
> Ensure that the sender machine has GSO enabled. Configure netem as root
> qdisc and tbf as its child on the outgoing interface of the machine
> as follows:
> $ tc qdisc add dev <oif> root handle 1: netem delay 100ms limit 100
> $ tc qdisc add dev <oif> parent 1:0 tbf rate 50Mbit burst 1542 latency 50ms
> 
> Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
> client on the machine. Check the qdisc statistics:
> $ tc -s qdisc show dev <oif>
> 
> tbf segments the GSO SKBs (tbf_segment) and updates the netem's 'qlen'.
> The interface fully stops transferring packets and "locks". In this case,
> the child qdisc and tfifo are empty, but 'qlen' indicates the tfifo is at
> its limit and no more packets are accepted.
> 
> This patch adds a counter for the entries in the tfifo. Netem's 'qlen' is
> only decreased when a packet is returned by its dequeue function, and not
> during enqueuing into the child qdisc. External updates to 'qlen' are thus
> accounted for and only the behavior of the backlog statistics changes.
> This statistics now show the total number/length of SKBs held in the tfifo
> and in the child qdisc. (Note: the 'backlog' byte-statistic of netem is
> incorrect in the example above even after the patch is applied due to a
> bug in tbf. See my previous patch ([PATCH] net/sched: tbf: correct backlog
> statistic for GSO packets)).
> 
> Signed-off-by: Martin Ottens <martin.ottens@fau.de>

Does this also address this issue with running non-work conserving
inner qdisc?

See: https://marc.info/?l=linux-netdev&m=172779429511319&w=2

