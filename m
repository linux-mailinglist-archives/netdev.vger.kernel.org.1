Return-Path: <netdev+bounces-245278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E810CCA4B2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 06:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4B4301FC39
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BFD2D7387;
	Thu, 18 Dec 2025 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOwb3T5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959F220F49
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766034929; cv=none; b=G0GC653DqqgVX8PGgvZlomhHpszMlwbhKGCUjRSGO3/LuVtwj4LcWN098jU7z4SywmIbiMofJaQT/mCcARqoVN87gTli1mQ5UgP/C+bke/ID4BXwMwxp4oESYsqtabT9OySH8bmCXB17WXtLHpiPrNLG4g2dMHM/oL5nHFU8J7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766034929; c=relaxed/simple;
	bh=u+3q2hz/nd8BPnGO6+jN2WuurkJ9fqrUyAzTEQuxhR4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mMWfDpECWlHaFR2auFnp8aMUTTIfmOUKDa5p/DnCn+l1z0Ex1UTiu71j40mLsTpu5S/6eDxaAzG+cFqbBgz6h9pSXQBntWje2j5MynISgT0T0tKeUb0yzVgTqdOfo1jHrLWItjrMhQxOuUYvu45teTIjbvGbGsi9pCd6YXuv+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOwb3T5I; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4ee1fca7a16so2077771cf.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766034927; x=1766639727; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u+3q2hz/nd8BPnGO6+jN2WuurkJ9fqrUyAzTEQuxhR4=;
        b=FOwb3T5IzJDWis2aV/A8I4cy31avy31iQkpwpsw1XyVTyQ3zziaDnhNJXjNcGYnoJ/
         6CHZLoGPfamjdx/LkDYH5sK5ONaCvYS8GAJQgkK248Rd8dMLWL4kC82PT3bg+MZ3SX8S
         iroxwXslsO4lDTNDfZNx4TuVCe8qh1zwyGdPOmKgGLZFoLasl1oR0ZH1j3V+KAlKZiJF
         mUB1eVq0ujmGazzPIoVyn3w9giSf7GBKQ4v3cSmodM2wOgL9Ln01C3e4D2SuVaXQG1xF
         IfV8Cg8Sux06Jhehe1bRIKV5wXVXUBZEH7HlMxOSAUWCsuaNoVlkKsZO0EtklT917/Yk
         wnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766034927; x=1766639727;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+3q2hz/nd8BPnGO6+jN2WuurkJ9fqrUyAzTEQuxhR4=;
        b=Lb5rsEULiZLRIhuHh15nTvZFV7+nkWfhfFMqzF5eqI7WkRLsxql1f4dw+yPDx6rcqC
         9pJ9hDT0echxesTLCi8HK5JLJ3hrUbsyr9Xi+KKo3lZxAGGiXz2pIJmKp6XAJpzuRo0T
         JWoTDF4PqrtCObzBnhmn98/nPKLIQXQV+M+clqad/vrlmXppWX9g5rsfmvzYNCjGSSHb
         5Qnmx65fCqW5qiv3hiRXBEQsARCzNES2HWXN4lAh7vgBpycrp54bjrexO2KbyamxpD8L
         xH5F61AsbFDs/w3zZhTbBXgLnocghrYHem3AO4zM6oNstszqorf2qRZ6cSMGiu5003Ag
         pzjQ==
X-Gm-Message-State: AOJu0YwePlY8dGauezHsCAHDf3W7eLYOk3A6oHw8xFt+2j0pkCYL1Pok
	982FnTj5T9ja9gzoZH7cwrCldJH/Lv+P4g63XKBUup7D27dFHOHWbI22DF2rloUcID788qUg4VK
	Ty3vQZEuC+2Dw+umjxt2RBTUg+nTHz9mO/780OrvEig==
X-Gm-Gg: AY/fxX4CCC/T7f+Wg09tWpuyE1dQjv+cPDzNdLLTTyaER8jxrKDBaqOvSzKSQ8Iydb6
	oPJ4EnRfqAa0BaQ5G5VlN6zzVxL7WpXWWKwkx26Ts8jMu9l2h3z1NALUvrRA5fHss0LvOBhQpNx
	zs1F8f7aQE+ir8ALoTPKi/U7+vSif7LZBlUaQ9UF008F61kN1xs6+Gb7l9XbuwpLrtnapC+bN6l
	cE9lKbGLzLH+IrMVIeEGVJ2IzHER5mJgcB9PCS1IMtpm2LEkj9IuqcOL8KaUjQTL1pzt0k=
X-Google-Smtp-Source: AGHT+IHOvRoDaU4gNJCqgnpEtvojpVL6sTp0GDWTqz9xmwQw2WeMY6oiUFynVaJNThnIGV4/ZlnMF/2imqF3b2DijwQ=
X-Received: by 2002:a05:622a:4c8e:b0:4f1:caed:da6b with SMTP id
 d75a77b69052e-4f1d04fc64fmr272694071cf.35.1766034926837; Wed, 17 Dec 2025
 21:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 17 Dec 2025 21:15:16 -0800
X-Gm-Features: AQt7F2r2WKbSgqnKBbZrCqF3jc5YhdLKGXGFSQoBW0ZkOJ2eiZKmQd_-v-3M_Ww
Message-ID: <CADkSEUgY=eQz+0VWzAZwH6r6THHEgJaO1-SYemANZGaKEaWkOA@mail.gmail.com>
Subject: Merging uli526x and dmfe drivers
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I just noticed while investigating the state of lesser-used network
drivers that uli526x appears to be a fork of dmfe. They are so similar
that they could easily be merged (with the differences being selected
by the device ID, as dmfe already does), reducing future maintainer
workload.

This can easily be seen by:
cp uli526x.c uli526x_undo_rename.c
sed -i s/uli526x/dmfe/g uli526x_undo_rename.c
sed -i s/ULI526X/DMFE/g uli526x_undo_rename.c
sed -i s/uw32/dw32/g uli526x_undo_rename.c
sed -i s/ur32/dr32/g uli526x_undo_rename.c
sed -i 's/phy_read_/dmfe_&/g' uli526x_undo_rename.c
sed -i 's/phy_write_/dmfe_&/g' uli526x_undo_rename.c
diff -w dmfe.c uli526x_undo_rename.c

uli526x has get_link_ksettings support and dmfe does not, and they
have other small differences which might be bug fixes incorporated
into one but not the other.

Would patches to combine them be welcomed? If I were to do so, would
anyone be able to test the combined driver? I do not own the hardware.

