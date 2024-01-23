Return-Path: <netdev+bounces-64920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4058379D2
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DFA2866D2
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 00:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AA128375;
	Tue, 23 Jan 2024 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1TifNA6k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFC1272D1
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968610; cv=none; b=jT8KYmpUM56FQT7wbDJ24sW3hjnalZRPqcQRtUAiQrjqTrNhuwBr9yHFDqmwgnCCnE4/jzURujgkvHuGLSFv4Hr1pfECj9Zrnn76TC0Bp6OPFfAWHxLeoRVtGB3c/e2CMgzx12bylKt43vU7jpjAL93q49gJOcwEXupY7bcmu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968610; c=relaxed/simple;
	bh=qhzHkKUT6whp5oxHlXH/6qo0TFMEWCgORJyBRQc9h/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4xPMCJhVSPhLFh+C1orcTiHM330Oh0WvyPNiVux6xrI1wxSaRBV19oPgnBjPFdARxVog7iF2OFEGmi8s7rwK747dlPLqAY/0dMbQnvbJVHwGubLNVdnaYYpO9yaQe4VNQHm+IlVV9IxIpHF2/RAkOIJqjCFk3gcRLA4ftJty5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1TifNA6k; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dd6c9cb6a8so1890b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705968607; x=1706573407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUf9VUVK0DdrXlKMmBz6paE8lXgiUWBR0VI/KN1qEqE=;
        b=1TifNA6kbyftOyMfAjwQxv55FiH27tm0w/C544Dlluw/bCNW2ktImRl8pKLWlWEU6P
         /89SifKUli3/sehUoueRzqhv5DI7Ls32/Ob456U+gfXsiPck9AOQG35rlMR8rBWfhiQm
         Frzbqeazwv+7GNhMs/2seZAn7IhruWQ3wpX5/CwNU/B77m7k6igiEaN51XvjNQZOHqt4
         vq69DcAgH1lgoIpOFLzJbexcryq5bqhMigTL2OILliPI5aFlP+PP5Hu+kAc+phU3L5JT
         jJy9f6xJC2li7v2NydcRjS5XWe2rRtJ6VQ5fx8Lw8Nduuoti+UHW0XVmn4Q4IeqqX4pK
         Brjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968607; x=1706573407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUf9VUVK0DdrXlKMmBz6paE8lXgiUWBR0VI/KN1qEqE=;
        b=EDdpMO/aBKyvSr1AmdZzBdUM+ggq2v9UmjQ3IU+7OT2DA6czPYEXpuqLvEd8GwAwL7
         aSM/gSZOnY3bx2RT7Pry1ttGnzsVqoUQi6aCgGhZxm1lLAC7yw31cqkdRjIefyuYog/p
         2y0orpWNXXwCWZKMqyhDYhdU2jYqPo1eVHrMUFRV97oWoTpLoHKAUWc0Sllzo+m8MNtO
         Srwr9Dscs9H9DULpNbixSvoNzAwtKA4xvoAQaDREblp9dKS/T7R2e9Vus3i4AUxj6hKp
         I/2VHmFzjySgaSPQZ5t3T3Mrhak3zNIRfJCAhx6sD6QTtfN0XuhwwggKD/ckx+pUaMmn
         E3GQ==
X-Gm-Message-State: AOJu0Yzsl2HQ4SwSuaiEGV1cp0FVc5D2lJF/an/cge9QIRjyMh2Upiz9
	bwoDCyVbbPgI39m65RFRJ8wSCWMknFcE0IxqRoJKGI5zDnXwAsWI/iQ2VpRJQSOgwePeTtT44Ti
	j6E0=
X-Google-Smtp-Source: AGHT+IFgfFaTJ08e5eeZGELAxjf7xSvqKmJtGWZif03+ynI+UghaMnS2v36pTLKvCv6XYppS//XrHQ==
X-Received: by 2002:a05:6a00:1992:b0:6db:dcc7:1959 with SMTP id d18-20020a056a00199200b006dbdcc71959mr1874301pfl.2.1705968607356;
        Mon, 22 Jan 2024 16:10:07 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b006dbd2e9be4asm4175236pfo.77.2024.01.22.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:10:06 -0800 (PST)
Date: Mon, 22 Jan 2024 16:10:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Bernat <vincent@bernat.ch>
Cc: Ido Schimmel <idosch@idosch.org>, Alce Lafranque <alce@lafranque.net>,
 netdev@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Message-ID: <20240122161005.29149777@hermes.local>
In-Reply-To: <d94453e7-a56d-4aa5-8e5f-3d9a590fd968@bernat.ch>
References: <20240120124418.26117-1-alce@lafranque.net>
	<Za5eizfgzl5mwt50@shredder>
	<d94453e7-a56d-4aa5-8e5f-3d9a590fd968@bernat.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 22:11:32 +0100
Vincent Bernat <vincent@bernat.ch> wrote:

> On 2024-01-22 13:24, Ido Schimmel wrote:
> > s/flowlab/flowlabel/ in subject
> > 
> > My understanding is that new features should be targeted at
> > iproute2-next. See the README.  
> 
> You may be more familiar than I am about this, but since the kernel part 
> is already in net, it should go to the stable branch of iproute2.

There is no stable branch. Only current (based of Linus tree)
and next (for net-next kernel).

