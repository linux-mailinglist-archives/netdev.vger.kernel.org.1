Return-Path: <netdev+bounces-154598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5539FEBF8
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E8161F9B
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452CD3D64;
	Tue, 31 Dec 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cIzV//S9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65AF195
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735606206; cv=none; b=t0teiWHMgJlJIUsz5qgd7gWHSlvau0zYWT21iLiyVTl75dE0XWDuHYgZ10i4IhVCHJ9Ebutcx9VtwTkSSfSu4pfshuhuWU+f+aswSthwQMErutBExe2to/YECGElA8OciMslT5K9iDPlNf0LGGUwaS12p4ru+LXgkqVyTE7IOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735606206; c=relaxed/simple;
	bh=bKFETsbQ1R0gjABOAMp5JDae1E3KJT0vntmS5hUVa1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtRlMzao+6DjUPZ8N7moI9BHGUw8k1X5K/YXbeM1Fe6ddbGklSOoCPJeg7AzU/ko14tGTLqm/Lo10ZSDIrI0ulA5l88IW7D4YYy/Mbo2fuwFziDL+ugjHzRamUw7a+g8t7XKZcBq+1GFhgPdgXWL8UmzdkkUeLIj4o8eY0NxRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=cIzV//S9; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f4ce54feb8so4761921eaf.3
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1735606202; x=1736211002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeF6ELke0jvN7JA+rWM8tyNwZ+IAyAheNO2iMC/8zUo=;
        b=cIzV//S9CsH26kErRwZIEu73CMcl/UuMOeRdHnyedxqP79SvfQ/vD8u026wQrZ4wYQ
         YXXZ0RxkBH41+jjQvE/1+tnDD2uWpiYgmEwGCHcOhWPO9pNGPGHt3nXzTDeSVBtWspbl
         6ZkKNgLNAt7IrIy0Naj6H2Py71RDtMiRhoykLhKXznMftQ/ROJSE5TfGTlK7IdgOxJ3L
         r/zOPVRQvSMf6c2YYtYgPgGHIbgZkMUd86QgFiPmxBmDdOjtHG28cd5gPrjmV6DZZ2nR
         PXY0E1kS9u+4YhgzYh9xPV8m8YWw70UxLwkrWzUY6xqb5E1m7f7kMiEvz3jfmveCFXQA
         RrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735606202; x=1736211002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeF6ELke0jvN7JA+rWM8tyNwZ+IAyAheNO2iMC/8zUo=;
        b=Ze7a6wGRm9WRIQIS/UjdUS+99Vl8cNfUtgZFShgf95R2n51khuPRPnLNdowM1UDpjJ
         gvgZCTDoQxm4mDNcC2xSol4fcXx99A56413s99fgldAw3NQrUMBgPEBWh8PAHA1Wd1QG
         knkJSEsj7ucOSX9Gn2QqYmH/1xs4IavkXNjibC0+B9wCf9TXZLzs1S3xSgekHGN55a4D
         bQmiaaiMnjeFsjqt6GHPHSH94Shcn1QhL1UKnrulwJ/6aDLF4jtQgB/9BapxyeJZ2zSE
         AyiPLLPKxNnAbKd2cNYG3HFeHv0h89iF4d7VONPD+lYhd9Et7chojd2bpo4YjxTGyxrO
         Bpfg==
X-Gm-Message-State: AOJu0YwU1kOXBatXEh2PJYZPgQDRARU79sc5tKiYycExyPY4L/n2spPw
	0GMxk6MigXALCI9JKNGfqC2iXQweEfSJlRyLJaUqUnxEmQHzB4g5jJf0DT1GsHA=
X-Gm-Gg: ASbGncsjCX2ZMN8JRtHLSEHTJuYfop7HvN9EKAHm5GOUGMgzPhPC9oNR0L7cC18I3yM
	/hMq6m1SOqfS6ZVtVwy1GqZaLVq2nq8GgbyNnzdrftSkRmvywhtpvfPEHiZ3FKiLpnXBXA+Far2
	67W5RpJCt7o7j+RwfO2XO01b/XwW4NR1+W1Fox7N5jHpdXH/RiJe+bs6KGrCWzQpuXzHl28QFq+
	1n+KGyaMgA6kQNVxJ5VHm0Pmz7ayTIxj1zXf22MEHXIETbZK56Se1ahwuKwkh0l4LGO+KPq4xWg
	xbjcVzAw
X-Google-Smtp-Source: AGHT+IHVMfysuweBnc+rBV2bc1QDMaqRi3lC6ese/WSj/mgbFgkbO/nLj4siLCo6d94BPjfe8bjcQg==
X-Received: by 2002:a05:6820:22a8:b0:5f6:4ce2:fa4f with SMTP id 006d021491bc7-5f64ce2fcbemr16457257eaf.4.1735606202723;
        Mon, 30 Dec 2024 16:50:02 -0800 (PST)
Received: from pi5 (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc97dca27sm6291344a34.36.2024.12.30.16.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 16:50:02 -0800 (PST)
Date: Mon, 30 Dec 2024 16:49:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <dsahern@gmail.com>, <petrm@nvidia.com>,
 <gnault@redhat.com>
Subject: Re: [PATCH iproute2-next v2 2/3] ip: route: Add IPv6 flow label
 support
Message-ID: <20241230164958.5f99eb90@pi5>
In-Reply-To: <20241230085810.87766-3-idosch@nvidia.com>
References: <20241230085810.87766-1-idosch@nvidia.com>
	<20241230085810.87766-3-idosch@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 10:58:09 +0200
Ido Schimmel <idosch@nvidia.com> wrote:

> @@ -2129,6 +2129,14 @@ static int iproute_get(int argc, char **argv)
>  				invarg("Invalid \"ipproto\" value\n",
>  				       *argv);
>  			addattr8(&req.n, sizeof(req), RTA_IP_PROTO, ipproto);
> +		} else if (strcmp(*argv, "flowlabel") == 0) {
> +			__be32 flowlabel;
> +
> +			NEXT_ARG();
> +			if (get_be32(&flowlabel, *argv, 0))
> +				invarg("invalid flowlabel", *argv);
> +			addattr32(&req.n, sizeof(req), RTA_FLOWLABEL,
> +				  flowlabel);
>  		} else {
>  			inet_prefix addr;
>  

What about displaying flow label with the ip route command?

