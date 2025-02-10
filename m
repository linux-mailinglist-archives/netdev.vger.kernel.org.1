Return-Path: <netdev+bounces-164801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43766A2F239
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0106160FCA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8A241C98;
	Mon, 10 Feb 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebQ4jtTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888F23DE95
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202969; cv=none; b=IF8n5utUyii7Gv83In/6E6XxyC8HyU5JF0Bhg+Ws8lPaWBIRYVx4jB6xcv65x0bBpIVfU2yGPy3LLftxKQ5AtUY0XbzYXhU9hP12BC+h72/q5QEk0mPWGKZOQW3fpnQKKXE7n2QuxzRUSVqt4Yn/TruUsezJ65ZghrcT9PIvWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202969; c=relaxed/simple;
	bh=JDWViGqshwCrE6Nlfvl8H3oqivCzwTY/iSH5UyaRT0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lakc+3AVUyuNh8FB/nuvjbdF72wuyj+T1PcvEURa6eD7TBccv4shqLvDKMnaSabt2E+EOmY/jn5Uq31Ax/Q9l2qClnNysqD5Y7DVYtrCfpBLXDR6UCydQB5ezdIA4hRahrAAbo93LnXzktpxZusvM7s4K7ipGzRq0LOR/tvIR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebQ4jtTE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so8882147a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739202966; x=1739807766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLczrhEnX8LtCEBU9Vv2CXoUE7ZoNRAQSyYxfOfEIiA=;
        b=ebQ4jtTEedXGuxf0z7KNZY78+Xyi6g61dhdjzgq9welP3Vq5GrPu+HRz5YIL43tb4L
         WxF77ysbVUKW92rjAKEcyVTf/7hzuxjq8KRWB5ZE2ZuDzqEiaCjl1Zic4PZoI824Wnep
         ZT0m0d1csbiwxW7XNdatsMBvncrLiRDiQc3SrrcpPPd5/EGZ9ZpM5wngC3nCOiFp0sXb
         QIpBFHXFxNNkIWvZWalf5BdSBJUjqC8685MU1/aGbVFpdEzirBRzE6uM1hT0sthFew0E
         Sw3KlZ0syRlyjTD44qcxp9LKdaPm6HinLdB7/pv+zILN8XOtGPp7mwTxPwWb62IPfoCV
         K2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739202966; x=1739807766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLczrhEnX8LtCEBU9Vv2CXoUE7ZoNRAQSyYxfOfEIiA=;
        b=uKW1MNR+OUMAfPxkuov1WMaG3YfCT6ylYKcVPJJ6m780f282KGKRgKanOYlGAmft/f
         YjpNunc4E7Ecl0rgnYo0bSZVf1LPI1FQheoFk9bqc1h6x4woKKcG6E7fBxcTRvnYAbHL
         j65taH/8Q8XYS6M5+NCE6yH07H7U8yaCsnHWiZNlYrLuaSWbNrWOBXPqW2FrgKijBYmZ
         UMFd1Mv1FyfuqtEeMojT7jPb1pJbaOVwzQZwTW2YhkwJcQeDe7BSch3T/i4d+CQuhiLo
         tDKl7CfiinkAIfEryV/OPxD0tt9lkrGpO4X2vc7aBoYtSjQbuMpQiGWK0iS7YAYoY9qq
         IEww==
X-Forwarded-Encrypted: i=1; AJvYcCWvLfj13TnM9D+0PZEAkybDN6BwT4dGCqsyYOXm5qNEPZNFhX0y4XoRYSqdCS+ds9oWK75wuhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYujYf47ttlR++yP6jMfHtQVSND/v5FHJoYb0s+ijm2ob+LOMV
	iJnYKyB/pTFKOfiiIVKceqVcketabaJtRAFl7YWIYnDMLpVXUE0yy8qy08uWTaSeZhFPYzaAWnd
	gkm8SNXMA0DlabtwEWAsB5Q3pcWW/jJwuoCI6
X-Gm-Gg: ASbGncvG/CV93d3TOddbPsIsGiCNhWNSooG9iL0+9I2Do84dlospWQTO9yOyeJIYRnc
	AeTEkmc0dUVCKmJos1zyFUVfdg2dconPcF/fEYEctRAgxzt9HPgYSHV7iDO/w+mWupczc5oJv
X-Google-Smtp-Source: AGHT+IGFWmgDm7hq6A6RaKGSONbcvRkAhKV9Xeb1PjCXX4BOk5HcG3obgtj/7WN8cuWYEGak/5HR9K8/Btxge7jTVsc=
X-Received: by 2002:a05:6402:26cd:b0:5de:50b4:b71f with SMTP id
 4fb4d7f45d1cf-5de50b4b863mr12936313a12.12.1739202966081; Mon, 10 Feb 2025
 07:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 16:55:54 +0100
X-Gm-Features: AWEUYZkdqEH-yIxQt2RFVMSzqvty10M-Vo581AAm7JrrOC4vyHrnC1UN4Is4d6A
Message-ID: <CANn89iJ3cT6BWLmFpdkxn6EeeLTM7rF0pwWGArq1gG8pk8orsg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Long Li <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>, 
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:40=E2=80=AFAM Shradha Gupta
<shradhagupta@linux.microsoft.com> wrote:
>
> Allow the max aggregated pkt size to go up-to GSO_MAX_SIZE for MANA NIC.
> This patch only increases the max allowable gso/gro pkt size for MANA
> devices and does not change the defaults.
> Following are the perf benefits by increasing the pkt aggregate size from
> legacy gso_max_size value(64K) to newer one(up-to 511K)
>
> for i in {1..10}; do netperf -t TCP_RR  -H 10.0.0.5 -p50000 -- -r80000,80=
000
> -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done

Was this tested with IPv6 ?

