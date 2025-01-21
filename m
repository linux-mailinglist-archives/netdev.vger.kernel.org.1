Return-Path: <netdev+bounces-160051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DEA17F65
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA2E7A1896
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A71F3D38;
	Tue, 21 Jan 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVYPwml8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB91F37DB
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468361; cv=none; b=BQRCA10m7RRf7Aazn8A0I+cvZODnpsTXipqgaAsc/rZG/Edcz5NIo89sE9e5TQg4y6I3ZA+uWn0QGk81XTf19Cz1aI7afyknTWmUwu13iU+ngDv7QKbV5qUcf4zeCwYT9MgUMuh0UtX6M3FGzhXMek5yTv+dB8kH5/hCBYSwP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468361; c=relaxed/simple;
	bh=GqWPxcBI1O62621uazEkHIma20TC1KqwE5qvtRMqGKs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I5rLB+bKNJjLxYUWQYkpksoPek8tNMxSKFqydFgWLTCpYxvmpfjn8+tOgF369wqSFXJG1O8xmf8LFsMIW20FbIzNEvl/VdZuahDgZQVei2WUmX5ow4sbitmPN0eestLZBcGoN9fSnxf6PK0kd3rAc5/EymCj+la1X2a6zCxTg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVYPwml8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46df3fc7176so53852771cf.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 06:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737468358; x=1738073158; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3uFLJiLya/36Gp3wG6AA+3zGGFK9QuSNGii67wdDtbY=;
        b=YVYPwml8uuZ9V/HkhwL3DaKB21YlQDzfnm5RvfAjjwf2EJhwcOoawp3aQXe1bC2nl2
         EMaJIhtgk6ahLAAZzx3iCQ60mcNAPdYl/jJq5fHdAT6q/WDq3J3FmlKSZAb7TNhhyhjC
         9WLU9Eui6jZkEMf+J96KU77GFhEB6RItPewIRKNG9rUFy+z8PVt87ZZDvDf4XYccAIGC
         vlmMt0ZYqaoyufd6kVVIngdbXArHRdNGTreKLxVkZrqHHGZcw6j1S4Yez61loNIk6XJC
         mL6C+B7nhLrtoLf2X715hR9wap5I6XFT5XHbMWF0QTujnYwkV8qtYjRerRYhRTV/3hCI
         MDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737468358; x=1738073158;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uFLJiLya/36Gp3wG6AA+3zGGFK9QuSNGii67wdDtbY=;
        b=gb+RDDFMoBj66+5xix4xjdI5MZUlfMB9UCVyXe0p+ehPgD6jgaORqdQzbYevkUoM1X
         56l7DGAw6jodfjm4FwngyB94Wzt7TkWkZrUA2T2MuUV+70ZiwxD7S2SlRK+VlQ6/Ti7Q
         7tjGWhVVPKfHowVn2puffsTu+Zg+CEpUYbVFxtH5xXWiaZRhBOLV8VOCF6mV6UIJ1o91
         sdA+dFKdDWYAnykMmLnx6WiHK3/2e2QxtnvD2JQ2/53yqoJUmjnSiZNJ8Ff3kJ6K4+B+
         OXpgbH75vv+3fLyDxb0p/figgvwMCz0bUyDTbuOjhGtRgNmwMuxBLVsGWlxBk8gJnKx8
         YYew==
X-Gm-Message-State: AOJu0YxfwAGWuxovbXX6fDdcFlf5/JItZudvjZeDlE3E/59sqt6Jhsa0
	p2W69FEUCMuYtBjUWeM//DvgzsP28LPF4Jfl5slgBMG1W2qq8TnGnIA6wiMvtP2Ti2U17wF13J+
	HFoJS54NznON/2CFFFRnWDdaPe5DDpFnd
X-Gm-Gg: ASbGncsZCJ6V1Y1eF6ARSiaRbD2tCkJSZqiN5JtmTU7WB+vKSlYkqOZe/ZePkqIpt3r
	p7qxJinbZBA352jkVrmptqBLH/uUzAPUu7Poqe4An8pisAO2WDg==
X-Google-Smtp-Source: AGHT+IEug9yP9b1sn9NbAGS9zAgazrrEMTyiFYcTxPnjI1QtfVeMXukvp8MBKGI4bsXL9PyoxcCIaMxPHiYS3RJR4QI=
X-Received: by 2002:a05:622a:1116:b0:467:59f6:3e56 with SMTP id
 d75a77b69052e-46e12b56ef7mr264954941cf.36.1737468358398; Tue, 21 Jan 2025
 06:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Tue, 21 Jan 2025 15:05:47 +0100
X-Gm-Features: AbW1kvaqp4HSRSALyAHukb7OrzwM9Z8cQ3jsSpSRkp3MfVbVzmUoMGsVEGnI5zk
Message-ID: <CAA85sZvPWgUdeq+R7t3g5G33TjDR+GmaNx-cCxjc=wtRapUOvg@mail.gmail.com>
Subject: Question about offload on vlan
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

A while ago we had a change that propadagetd offloads to bond interfaces, see:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.6&id=c6b9b1f67b6d6d4188a10d0acc9baabea3130fd3

But, if some offloads are enabled on the bond interface they will not
propagate down to the vlan interfaces on top of it.  I assume that
they'd have to be stateless, but i don't know the implementaiton so
lets say f.ex. the esp offliads? Should they be able to tun on a vlan
interface?

Or is it the fact that this is a tagged network that causes issues
with offloads?

Anyway, questions seeking answers =)

