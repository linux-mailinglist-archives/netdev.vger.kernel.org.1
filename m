Return-Path: <netdev+bounces-204431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5AAFA66F
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E073B7DF3
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1F022F75C;
	Sun,  6 Jul 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdFYlPis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2439FD9
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818650; cv=none; b=UZmGQYA0uYZ1fQqVvqPN4dSzw4UV+HKgp98R7OfDcZC86TkR5IzD7NymjeXlhjsH68Pkf5gBS1Xyoimkvjeq2M2RU7ycu8xoe5a2C2zorwHQYJuzCnH0zlQqVBd4WJqksXfoBCUBXcyg8otiUvbU/P/+I5W666AZWkgsj4SqBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818650; c=relaxed/simple;
	bh=0+LZphCMTd6oKuBvbRVm7P1owAGwrZnr04bigPooFts=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RWvJaG27rSuojWjqs9axropOTDH5fw0QiRzrz1s2I3jFR1Jba8XAZSNt8jNxPTqx1utsrU9PFknPrYppIvvErKAIDY6b/o35TzWU2ybbNwFq3GtQh/s7V8yFqlETYAD+emq5YelzA+sHiVzghOtdCXYwH+ioYAox3AdZJXUR9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdFYlPis; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso1955347276.3
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751818648; x=1752423448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph3k7/LZNHNlcaE94RB1/YwNDXz4V5wPUPlAmwBK0xQ=;
        b=TdFYlPis43tphgv0Ty77fuJ9nsd4RBRQSHWb9l5FZ4Rt5bTjlnUGnojufEQKviERjF
         j1vu+6aaym62IgyXcx1cvBr86c1Ct9GsnLkw+fMaq0E/+ihrvFSdfOMlZoeBRBe90AyH
         c1W638D/QqlF0tzIKNr5PVYEzWyj9TVcfKSBWU/zsmrUmR7bjBS35Y097n3ow+rbP4rO
         pyEyENCmlOFS5hQom6X8nhFUIXPo/r6NgAr5Hm9V94JarvjXWmJ6D/WI/LCFAEfRBUOU
         VSh/yaOm6T01z84rwOPTAWfP0o0S/PS83qM9U/9okhRZbQOad5gUfHnCG18h36KJb1I0
         bluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751818648; x=1752423448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ph3k7/LZNHNlcaE94RB1/YwNDXz4V5wPUPlAmwBK0xQ=;
        b=qyiweIJ3cEfWZQjZS7fyFMVY85kv1MTLJaGJsBrRWYhx2uRPWglSSorjNoG3eC982g
         y7BmMGQ2Vn/hedYZQg56ZSPiZiZqUF+VNImarMNTGxCXsyzlMpEXS4aW9DijEClSMe7u
         6x2wXwanmX0AeWoUaHWra75Gt2hLcgi5OfHLzxmH4UAFpAk1hugrpnqoRvn/knegB5jB
         08I/ES7JnC/cJzR3wUA3woQ9/9aCjXHaKuOt7nLIvKZU8V5aO9R2iwAgjDsBta11wqwn
         dtkCwQgBLwLUX08ZfqWLzmyin2OG3CpbXqTeZhYYT24Q+1yN87SUHkfmc9sOWCN/D6ZE
         2DGw==
X-Forwarded-Encrypted: i=1; AJvYcCUtcFlTJUz2z5UPk5ig+bPUd6VbyYdits4TXZE8guZw/DqK0rMWIWSpjyXNl1v8qHy/bEylE2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYm3J98iVfp8Vwf/2x/p8brs/HLDTYhWTDw9tev+iIUZxYAVD
	wRAvGCX5zMuoJz5ugq5fglZ68vmJ870FpO8zeIWJdBQo1uszeRDgpJIf
X-Gm-Gg: ASbGnctcNHJ4tg1cnMtQWMwzZGjbVJxxXgKF6u2RsjSnfgSCelZhXmvxB955vK7G2Lr
	qib4AYfeE5EQzlQHdZkjut849LXoW4n25E7y7iyRcYgkGq8W2i7qHagXWjY2l3jlyOtp+nrV1Uj
	6jFAjiyoAxcFZdqQtKfKNcz2705PUsVHKQZ+W1eaj+eqrGVTzmMSV7L1z6OLE6z7H1fdQMNB5HN
	kD6+p912Dm0pJ4lEzQM5W5tzGRibWEbtDH0DeAGqqFLbmYu5z3ShJiF0KBgu6OifVwtAzuJGh3M
	CdC3fFWaW9dj1jNR91pRK9zegc1lwzEMpDHBR1PO1EpWZWNXsFiRv8RHkVnl2tLNlUYg+WO83WY
	a9nplX9iEm9E98U7Fm/iO/dxZnIA+Wxqq6T8RdsM=
X-Google-Smtp-Source: AGHT+IGBCMV8ClSJSAh+0iokCuzMwK0eNPN+fl5TZYvQzUybT5j0MA50LYO0j2QvZqfG979NJtcwVA==
X-Received: by 2002:a05:6902:726:b0:e89:6aaf:3cd9 with SMTP id 3f1490d57ef6-e8b3cd81494mr6055456276.26.1751818648198;
        Sun, 06 Jul 2025 09:17:28 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c300fb0sm2063272276.8.2025.07.06.09.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:17:27 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:17:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aa196d00a5_3ad0f3294ce@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-6-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-6-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 05/19] psp: add op for rotation of device key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Rotating the device key is a key part of the PSP protocol design.
> Some external daemon needs to do it once a day, or so.
> Add a netlink op to perform this operation.
> Add a notification group for informing users that key has been
> rotated and they should rekey (next rotation will cut them off).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

