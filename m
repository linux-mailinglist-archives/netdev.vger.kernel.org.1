Return-Path: <netdev+bounces-154765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68599FFB49
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA187A12AD
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B71B415D;
	Thu,  2 Jan 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lurMbOuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D191B4144;
	Thu,  2 Jan 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833683; cv=none; b=Q3xjtcwW3GNu7svjKry7ajr4PLqTWjFUziTH7s6DWphGcyzAzvRql8TvoPX2XES/FRK6G62lbr9OyD7f46SWXgCl8Y9a4m8JdQZVYaatAImlmVJBrQ5af5hilw0MRu58mNkXGrz9t9XleGU2/GB5ym1VWYtug93nrKpt0IkNOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833683; c=relaxed/simple;
	bh=VjDvxsly0BH4NzT+IRTvfxPmn4b6Bp8DG9daG17H8I4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O8YlZwdTfb1elK1om8IZ2ctwee/S2PN1gosw5W7AO1kOdm/tpjzmRMSV6nd/eQU9pgg6zyw6wMZc42CtwHi69QGPN1N/iyPv1DbdUZznrXWVbcqf37rkBhieAJwO7Ious0SHJPDjuKoocd2rXdJYqRsxbDWZT8x6t5iKTrK5858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lurMbOuV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43618283d48so83673725e9.1;
        Thu, 02 Jan 2025 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735833680; x=1736438480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjDvxsly0BH4NzT+IRTvfxPmn4b6Bp8DG9daG17H8I4=;
        b=lurMbOuVjtuuFpOnKZXah2oWtpYZhJdi+P/dy1TNg0nP69cNGUHyb/3fHJL48EGUWS
         Ekk0rB2cioyB3Ozacdj7Jia7sQgiWYpDGHVnjUM4Jpk7EdDlWaK9Z2x0U6NbyxXCFpGR
         cBTsJg4a1fQShP+JEoV0q4d8bScHdjlfGPut6de0MIuqJpWpX2EA6+Wkc6KCrUa0DyVQ
         kVIiay01TJwKO8xnx1jOcm5TlbF+CfTeFRAnRcMIjxq4thWUzKdBFhEz5L42LelUFmYl
         qQUIAYDgo6c+uIJCgE/RXN+qfgIwI3Kwpi3juJcMFPu0Qz/g0FNSRXFZy/HCMGQeM3Zw
         lH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735833680; x=1736438480;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjDvxsly0BH4NzT+IRTvfxPmn4b6Bp8DG9daG17H8I4=;
        b=OcurN+l10uPci/Usgzu3TkCphQysSuFdcBmjzjEzk6Va696aF89fX4vZr5obmDVzlu
         hYEpvFSZ0TfkpPDkA+yyS/Glc8RzGrKQo2oOKlpDtjHKJCLjrQa9ByTp+g77vVuOpJuo
         z9PY//8N+O/4njW4CZqAdY+vySqtwTuGp7Ud5bmEZ7UNg4R1INKNm1II8xL0cNBqaAr5
         LsapEr37SCvdVSqfT6ZGerlsxa53M0wCwwULlbrnq4p6AQON0jmg/CKOTUHC9Fl9sXGV
         iCHqX2K5xdI1IwDPazzD1q1LSdqNS0D+6SEpI4y0VSUJy6eMpOXwzkjt0mVB5byMiROY
         eVpg==
X-Forwarded-Encrypted: i=1; AJvYcCVjXXGCJzwUqqN4q/HMe2sOUQgf2fAtVPZLvCXnqP7e8W92ZngtzKATh4eSQN/vewRQYbMKa01SJ80EyWY=@vger.kernel.org, AJvYcCVsKpToq1hg7SCtahKRrzqPy6ZOrcDsuddc4YJaxOHSXUiQIlXdjPO5VEStDG2yu3YmF5ckxc16@vger.kernel.org
X-Gm-Message-State: AOJu0YwPz3DzlEU8flWpa9fH4mhYcNJd5CsPNEyEqdnirVrPlKL+aTju
	kkRA9hAEINebh2IpKiUJHCR9AnZvOl+A8wbgA+hgj/6hTO36tG65
X-Gm-Gg: ASbGncttszoODFJIWQ/Bn86NKascg4+c0Bm6W7wHS0UjbpBxSTFUOWuoYxUmev5DfUL
	PViH5zI1av2yI4bldU90WTNr1OWH6i1PjBF6cw9zRnMlal9nN8OY/QiIs+qWSzXDd52uI74DC4u
	TuNFXzGJypWgilCUULG2DUPdpFuykQTUveMBK0oz6D7Y06Xs4ASVeewGOiuLs++XG3zf7Sh+Twf
	WwdVgFfZx5TGxoGqdCeMAR5YCTxy0s1ifcPthKE7yyaApHYvfgYY4zYFduvzwxEg3aRgcp6fnxb
	7xdTHUHHFUg4VX8o6td+JI3+Srj+i0JXt/mTax8lhATd
X-Google-Smtp-Source: AGHT+IGhMQp+xDDDjLTohY2Xyoz9SB3saaToYRCcSeHcyJLBvMiZYJC+z03YraYzEiVsqOynkppX6A==
X-Received: by 2002:a05:600c:1d1d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-43668b5e172mr371349245e9.22.1735833679939;
        Thu, 02 Jan 2025 08:01:19 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013e1sm484963135e9.12.2025.01.02.08.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:01:19 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bQuestion=5d_ixgbe=ef=bc=9aMechanism_of_RSS?=
To: Haifeng Xu <haifeng.xu@shopee.com>, Eric Dumazet <edumazet@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
 <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
Date: Thu, 2 Jan 2025 16:01:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/01/2025 11:23, Haifeng Xu wrote:
> We want to make full use of cpu resources to receive packets. So
> we enable 63 rx queues. But we found the rate of interrupt growth
> on cpu 0~15 is faster than other cpus(almost twice).
...
> I am confused that why ixgbe NIC can dispatch the packets
> to the rx queues that not specified in RSS configuration.

Hypothesis: it isn't doing so, RX is only happening on cpus (and
 queues) 0-15, but the other CPUs are still sending traffic and
 thus getting TX completion interrupts from their TX queues.
`ethtool -S` output has per-queue traffic stats which should
 confirm this.

(But Eric is right that if you _want_ RX to use every CPU you
 should just change the indirection table.)

