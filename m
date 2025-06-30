Return-Path: <netdev+bounces-202374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D476AED99A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4C8164276
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B623F43C;
	Mon, 30 Jun 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j88dlpro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809223FC49
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278727; cv=none; b=jj2PTA/TYAyFK6IEaPrHUuAZjx6KXdPks7lbBI2C9l9W5L0BFDkjE+ikz/WtbNjOdLXTXqP4rfyTZgYKWT5GY/sZpZUuwhHR7D6WluiT/3kA6KyjQfc2GhV49S6n3k8f5W6jgA+Usts9AUioJTzI3VAc98w2qbNO1i6D+7XElO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278727; c=relaxed/simple;
	bh=Nk+KfaEiLQxq4F1/eRxzw0acvPZiE1jqN9v1wqJYe8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOc/vA6hHiQGQyXfs/fWLQ/ZUbwBR5efHScU3swd5S+x9ZTR6lbDX5/ow10LD7aWlyPp0iwkdQZ7vj34ACi6E7emVD0heei44cmhsJpjE0cNC9UAgsxb+Q1gKjSwJ8+5yDBc3ZNhUD9IDx99wu4ckkGLcvgMqh746POUkOP/hgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j88dlpro; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7494999de5cso3303194b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751278726; x=1751883526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9J78OrGffvObrChvJv6rWEfHKj3bf7n85n0Ln/cIZM=;
        b=j88dlproFYZgtvONn7J2NOYfeXLql0Wd0/zhw1E+6FyMUkeBZECux3rI/4sxIyQIZQ
         ez6rXfUOaUpyksi1rEPrj/WECzoqViNFT8gWeNh+dr0ENkcfmbs8Q8C/6Jq/3EtOa9/v
         tExd10eyR9p52YX42sL1AsTjXUY3Lbnw720NAjmKq2s261OC0+BbOTGGZg9z5FQtdIiC
         zQ4zjLFTjqKVrusDX/NDChzcIBAf1+2y+HNKoelL0FpcQom7QsvOzOT6BwFcv2/lzXS5
         T7dXWNJihBZ8f2WD0S23EMAAppMGdd76bb9KdSL7wRDe6pJDB+sf9s9Hmu1PqW/ogZcf
         fNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278726; x=1751883526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9J78OrGffvObrChvJv6rWEfHKj3bf7n85n0Ln/cIZM=;
        b=J1Sm39M7Bd2aBdHarIk4X2xfJX9wX96n1ID8T60ND9cvTK1UAMzy3vV+CGguvBRiv3
         fNkJyWEbS+PsDyR8MbqT9zQ3aIGo2wlG6v7zIoEmrRx0Bm/KuWjzmi0e6CXAoLczgfdh
         QlNXPV+u8bNCo9qX1SzLepPzKP0armBzk76xxABjGsG+F5pwtb40Q8T+4rzM2gKyizLu
         1vzbQHu1eY2ssYVEwmAleBM8+lpr4pWx3L2pNC8CVmTEPbY24llhGWi/vY1BqvKeOUf9
         hpWKNEDScR22kKOmv7F6rk1GooV1/dAGRItM3vMklz2j43Eo2XumXKXENHn5HuYJkCkG
         +mnA==
X-Gm-Message-State: AOJu0Yxn75SFwRe0htdznfDK9MMEoQljZRDbKQlWK7bg64meVGf01/s1
	jhlmb1llvqnRNW6fG1V4yAo0kkJ7Wyjs1e0FAv8J35tBFXVxoGkLrK5O
X-Gm-Gg: ASbGncs37CN0ibfv8ImhPy/snSXNub95NXPCHpkLi1gqiesZ9QFCI8vs2BBTkNzz/z7
	sFV4xP+GVO8X0z6+Ct7VosV9Rax/QihOj58j+Bb9HGjZJgL08ZeLCgyhpQo0Lh4fTf38sE/dx3B
	vAaHj6hHPYAintgJWZ1ExSM6P67MRV0h+aLp2VXcS8lMyMQA49JsbZo5kwtWy0APhHXAEyaJVRJ
	2N6N2VQtAck0awuVyM0Mx/bX+/xA9PECownTzyOam5RkLQbP6mMo2EkmXzV//zfxHSQf0z1FgYG
	2vO+3kj59vHGy65LAXcYSpgsaR8LEpv30BH/2kdy/iDvK+JZFsumMThIBdy6eq9MpRo=
X-Google-Smtp-Source: AGHT+IFLQIFRfSf/sC7u9xWEIWgAigcQnwb6+QgYUC5hPv7uXqZw74It36zprWQoUdBZkAksqNlGoQ==
X-Received: by 2002:a05:6a00:1ac7:b0:748:e1e4:71ec with SMTP id d2e1a72fcca58-74af6f57628mr17180232b3a.12.1751278725684;
        Mon, 30 Jun 2025 03:18:45 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ebcb5sm8556757b3a.151.2025.06.30.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 03:18:45 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:18:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
	pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
	haliu@redhat.com
Subject: Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aGJkftXFL4Ggin_E@fedora>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627201914.1791186-1-wilder@us.ibm.com>

On Fri, Jun 27, 2025 at 01:17:13PM -0700, David Wilder wrote:
> I have run into issues with the ns_ip6_target feature.  I am unable to get
> the existing code to function with vlans. Therefor I am unable to support
> A this change for ns_ip6_target.

Any reason why this is incompatible with ns_ip6_target?

Thanks
Hangbin

