Return-Path: <netdev+bounces-177238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B9A6E65F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA99C3BB36D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07081DF73D;
	Mon, 24 Mar 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWurTxdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90A1531C5
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853852; cv=none; b=lfKRwG7BEUBbGcsv/7OVJ7NOVbVlwm5ltpz4sdV09s4rIZzzOj2ph9KJWwiiL83UPn1JW4JgZGCu8Lp1LmvwBbGdJj38+TfrnJTkn7DKLEPQKVlWXOatdhJ00tyWTgUscLOMIR8EZyKSZL4lLqCE23yrX3BTXSoSd9XUh4re1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853852; c=relaxed/simple;
	bh=TVTDXWmqjzWOzNiDXlhdQZ4rFVkeGh2mB6EPK9T+500=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BTSOtrLOJihe6oLgx9B5Deq1PU2ch9cOJ6Wc+SiGsJ6Bzr0gyCaowwmyvMdxFdoiJkxxFL4gRXYE6R8Kgp/Jq8noyd1FX1uOsgI4+UlAZcswladqxTovBW3VaGVthJm6BzdLzRmP7tQRnpMuuNnJKdqKdLbaM0Oxyz4ZcpMn2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWurTxdL; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523f670ca99so2318993e0c.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853849; x=1743458649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TVTDXWmqjzWOzNiDXlhdQZ4rFVkeGh2mB6EPK9T+500=;
        b=EWurTxdLWFSHnIc440XqVUXFLoIUYBz6PAuQrnQ+3zV8RuYcy3nYwdN+6rHadG54PU
         HxIq3ABbBftV85F7hNf/GJAF9x9nwGERZ/cpwsg5q8KEWSCY1ckyZTMio7/+Lpy4ZKco
         aL8uPCGxjJDMvO/HpVzyHDTKjU/KCn8QRqaOr/j8u4lx4SNgD1PB1mqND1e6g3wJ5xLE
         AcI6cjPV2Oi9XAioQtMpoQ58vMs7YyqfP6xm0m7BOFo7fisR4kV755HYFH9DdhnTlRKH
         eQ3j0948GQiiZAA2pIAeTquQqmFtM4MlWvqyDvqa1HUlQpvdg/M38lyUVDyyoCbiJqKm
         EIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853849; x=1743458649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVTDXWmqjzWOzNiDXlhdQZ4rFVkeGh2mB6EPK9T+500=;
        b=wEvyWBjndBgMVzMUiDNcc9f60reFJ4OfiYVBnZOwZEVKt8pcaOY/KvU1URGhf9Slyg
         LlRSfN9fSGvSUUFWttTOPM1/nPiDaHmZro7+P9GiujtyKguuyPp/zaz0V1KmU2/ci5ER
         xF6TgkfuU9utJOsXLu1cojk63LN76GjwHWhMBBiA+aUheQZi2XnF5nFI+zSl9Tafriy3
         1U8AX0Mt3rWf5aSTzKnQ1tPhsEPOsCs47T/ZIV05Dt5Smabe3D+B64KD6WBRg1413uYF
         uYOMoi3ZG67VV44zSzV5sFx/3GCef8aGxwWMTRFYL/cHmKBBiU0Es7ZZrb8lQMTTi7K+
         abVw==
X-Gm-Message-State: AOJu0YyhXrxttPM2tdA4HhchEzP1AlMBiGLdSOkTdcOuYBTf4agCUqWO
	4bz6rFPMn9IMx6N7mxPRVWqn6waQQQJrTJ1ENnz+WcTSsSKuVEP4pBoLn76gGzZTXb1ykGfhI7b
	m615hejVvgNeWf2f8t+j6f8nCSBpcqgML
X-Gm-Gg: ASbGncvRbSO+0Us5Mrs+n4XGvnPMRgBsJQRe9a3zr0tqTAnJpy6PkX1xKdFqCe/1X0m
	QD9jzoJpNFQbXq3ElBMuvoy7Z+1bWLEQJDMC1/ob6NS3OPcorda9vbM+iOKYpgmAVx7casHlZ/s
	1n5XqmrNG7nu4k98ywml/P/xEENA==
X-Google-Smtp-Source: AGHT+IG+jTVWV7HigJTSNSzRf40raW76JOIW69oKnYeixKbgUZkZ3AhMMwowJ1rdodb5VpvtWFkVMBvvpTG61Tje1Bc=
X-Received: by 2002:a05:6122:3d47:b0:520:42d3:91c1 with SMTP id
 71dfb90a1353d-525a856056emr9996771e0c.10.1742853849501; Mon, 24 Mar 2025
 15:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Mon, 24 Mar 2025 23:03:58 +0100
X-Gm-Features: AQ5f1Jp0O8vbcohNNOYHg6Ya3_3NLnVgBeIqNn2P8xHfJ7VjCru6fWKyMDcpauo
Message-ID: <CAA85sZsxTsHq0bbrnRwbD9XmUzFk4s5Loabpmqyw7hipyTcUDQ@mail.gmail.com>
Subject: [6.14][mlx5] bug with wireguard and rx-gro-list FYI
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I have been wondering why my wireguard connection to another part of
the building became extremely slow
and almost unusable - even issuing "dmesg" was so slow that you saw it
update in chunks and it took a long, long time
to complete.

Well, eventually you get fed up and angry, so a wireshark session
reveals that there is lost packets and ALOT of retransmissions....

It turns out that disabling rx-gro-list on the external interface
fixes it... Everything is now fast again!
(I had a leftover script enabling it for my old config, turns out that
i didn't disable it as i thought after all)

Anyway, FYI, enabling it causes issues with mlx5...

