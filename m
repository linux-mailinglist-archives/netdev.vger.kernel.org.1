Return-Path: <netdev+bounces-247795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC84CFE83E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E255303A0A2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DFD349AEE;
	Wed,  7 Jan 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CtEISEka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26139348889
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798306; cv=none; b=jIUrholPT5fLsJXHfozT+DQZm8ydurbD3hlOL0+JBhrEwLEwtKYAJctY+00PQYR1gdfEsyxYhm8m4WCaLIcg8dd+wpiD0NGZHCyKh1Jkqg2QAJWGEc2G+TnWqDLlg9ULI5CZGvHA0h/PvwXUgzIpY0giaKcmMtQo+lhPTnYSzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798306; c=relaxed/simple;
	bh=D5FmglVvkl3g4DuAXZKkWi0EAt1o7Pm+KQPATu7ybOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkpMBuBQSkxCfaDmXahEMsiXU9nTZBxpEUFKc4UGML2+MQI9B0brwOYDJ78fkYZ5Uqr56urm2LAm5bQm0BhENnaEU2kLxNrtmZxfeyDnTvu2mexIxw4W9uLbT4e4WRzLmkxnawqaqHfTTJjgrc0G4aHmyUa5FHpjERXUEglA57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CtEISEka; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so14837205e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 07:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767798302; x=1768403102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UZ/7ZMF+GZy1qUkEJEGh+CeH3UAPpaGuj74Mgzc+UGQ=;
        b=CtEISEkaNSereDkNgutOh7W4rCw22UG1W2ZcLdcb+1OL/hlRe6fvz0JvcsMBNtYvm+
         KPVuHN4H7/k9KzsHNuRnBGTrghn9pU3oCdqZADXMgU1im8/fZrpk0UFX7SIoieFQ2DfP
         kRUnUZqTRe9TAbtN7v804XNFsbTJl8crfBpzhC5Uw9R79Oe+RLqISte6UiuG3sWDqBC7
         WZV9lQ/oQb6vNgypSZbrQDWeeYWLauKuj1Uisv0c0bznKx9/3SAxl7VXf4zl3gbtlCOG
         pMxHfaUZNckxIWJJ4aMf6xG0V+4jP+zZv2ssCvrGpjFoC/dR088k2aMezSPFbT2QzDhA
         93kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798302; x=1768403102;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ/7ZMF+GZy1qUkEJEGh+CeH3UAPpaGuj74Mgzc+UGQ=;
        b=Eb8iaCszW5cSlDsOIDPNYgrbCNS0ce0VwNWU3F+udamA8r0QVo16owpqYxBOqpYsbU
         IwK5SEEkBMMaod8mn0KDascd4oiBcfaiYZL9T2YiiypAriHuB/8uvLkxqZ+cU1UZRRbx
         hNmYFIeHwp1OAyYUurvXFtBfn7jJwEzj+NS4CBrmLcyOS4/Hlwta7vPHVD2d2zHmlBvr
         zRvTpc6BndyRe05w+xsRExDHghZcF+U9//viCcl2iK6JLyxQdoRHTLJoaGh7DdYmpFZz
         2YDpIhPDghKJ51PpoojWHUbadwrSaPbgKjsL3M7lcvnh2Gcqw2SbQVqdSQQ4hoGutcSA
         hyew==
X-Forwarded-Encrypted: i=1; AJvYcCXhu14vcmKLgI/JxDDu3sSM97ISIrXm4T8hwom4m2KvpbbxTYf0ITjSZ7CMc4ayCYZm9Nd8Lzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYPFzl4TfHIzZ693z+8naPT0JkV2Jfexw7LQEp5espK7LlXd/
	azVKSD+EWUacc7bySN8PVgKb7M1FMDgbc8TTe3lLf7Of/h821TwUv5dqoLuEWNNNMm8=
X-Gm-Gg: AY/fxX6/3MWjj+p0x8+BV0RQ3x1XcYsyPFQ8ORh7SI+1YJeyB9n3/4zAIHLkggTcn2l
	yGdO/+FqiBXQMWbXuVD8/kbtoa2DIo9ICXDDqp/r10K0ZJZ5c8oZe3fl9/iCyfo+U+YpDBtYOfb
	5e/Y6YEDXWderkSipvW5w876sDJ84ZdbM68Z1xf08EqoNSV5LqLNMLwYQKrKgZ5fDXyau6HUFSx
	0sa6M83Mo/F8PaQh/LTy7fLGYSXCWYno5XKj+3q8/d9SUNkNRDrY4W0XrOcgfy9yQgCFPy5RtcA
	XuV537qeduXMUHk/dKOJv1/KkyoRDqZpjlz/s7VjP2b8/wiJDyl2bA1LBBxZGsLioGRRH7yTlaR
	3I0V5hNdpEZO7DmpWKAjfR9UnWn5Z1mfo2ykTv+3+dkijb7l55DdBpH5hFVNXYqPMTmr2BpfDQq
	taxYujNwXbX0ZhlU0rn0Yaq8sBOKzMWoPstNwj
X-Google-Smtp-Source: AGHT+IEOYlyKev/JXhO6ZFSHDXlM8eUuok0NFZfe0rNvo/VSyQSXG3Dl2jreomEhLjqpb0WuT9HVpw==
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id 5b1f17b1804b1-47d84b4101dmr28129435e9.28.1767798302280;
        Wed, 07 Jan 2026 07:05:02 -0800 (PST)
Received: from [192.168.3.33] (9.39.160.45.gramnet.com.br. [45.160.39.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee24esm10984075f8f.33.2026.01.07.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:05:01 -0800 (PST)
Message-ID: <737d6c96a51b5975c9fd7ed302df014e0d5e4fe1.camel@suse.com>
Subject: Re: [PATCH net-next 2/2] netconsole: convert to NBCON console
 infrastructure
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, 
	efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
	kernel-team@meta.com
Date: Wed, 07 Jan 2026 12:04:55 -0300
In-Reply-To: <l5u6w3ydgfbrah22dbm2vcpytqejfw6aomvzl5uzh5vssljqxd@suspm42neo2z>
References: <20251222-nbcon-v1-2-65b43c098708@debian.org>
	 <20260102035415.4094835-1-mpdesouza@suse.com>
	 <l5u6w3ydgfbrah22dbm2vcpytqejfw6aomvzl5uzh5vssljqxd@suspm42neo2z>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-06 at 07:43 -0800, Breno Leitao wrote:
> Hello Marcos,
>=20
> On Fri, Jan 02, 2026 at 12:54:14AM -0300, Marcos Paulo de Souza
> wrote:
> > On Mon, 22 Dec 2025 06:52:11 -0800 Breno Leitao <leitao@debian.org>
> > wrote:
> > > +		if (!nbcon_enter_unsafe(wctxt))
> > > +			continue;
> >=20
> > In this case, I believe that it should return directly? If it can't
> > enter in the
> > unsafe region the output buffer is not reliable anymore, so
> > retrying the send
> > the buffer to a different target isn't correct anymore. Petr, John,
> > do you
> > agree?
>=20
> That makes sense. I undersatnd that the ownership will not be
> re-acquired here by just looping through the netconsole targets,
> right?

Yes, take a look into the drivers/tty/serial/*, some of the only
reacquire the context to reset some hardware registers, since the
printing context was lost. In this case, for you, I don't believe that
you can't continue trying to send data to other targets, since the
original data is gone.

In any case, the context reacquire method is nbcon_reacquire_nobuf.

