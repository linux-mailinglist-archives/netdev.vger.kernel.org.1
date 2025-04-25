Return-Path: <netdev+bounces-186705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4532FAA0739
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4343BC4F5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2122C10AD;
	Tue, 29 Apr 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqA37ttT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4E2BCF6E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918853; cv=none; b=myTDjeMhWPikHCE9eJxLb2uplHC8JrvrAy+BIYSgj/iXZehx6cxCZOD1lVkRzEV1npSQf5kub0gmWJnZapsENjlTJgKnxe2kDj11NoN9pILPIu1oKtpXg1NXsxcWjGy+YGlfOjC4DhT3RHxLseuSnadTyQRQCZBYVBrKzIZuH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918853; c=relaxed/simple;
	bh=tRSEs2N+QYB/nkNFLgi0qjH35kXVBhyF3kuOSCE40a8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=mvTxwGknz4PttTqYFLQgaASkJU+IyzHSO0IrnfoNGQqKqLoAPdZaTQMnqbnGqAgE7B3DxevcCFPDzv6dVeFZXflLdUF1dfcvVRYvDc8yL+Jzl6BLV/NBSXQmdqPB/rJLmjQOv6fib2d9QzmsNVVcc1FFrinVRWjTFQ0OMqKaUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqA37ttT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a07a7b4ac7so1650655f8f.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918850; x=1746523650; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRSEs2N+QYB/nkNFLgi0qjH35kXVBhyF3kuOSCE40a8=;
        b=dqA37ttTbIjum0cEYKtXtnN4sleZlUvXLCLNcV/XF9Slt6/LCf2eghD2//bzmHJmDF
         VZegmSV9pnbMYeFT9ZTy8FOCFpB1VkR3rhZcdf3JU6e49kTWWjMRwggrgVfed6j5be5x
         nmTo416koR9enj/GwEQx96szIBsr5PetmUXw/EfCtptAMYHXScrgpGiPLZZzEbgSyXDi
         qeVDU6vHZChacRQ9v4Xy41Bu9t4l8FT1lE3JX3vdx68jISw5Di8kni1k4AN/rJ358vo6
         z0oBcCYv73yR3Hkm8iqD6bIYrq9XOoDR8mK6B2P8XzhNp3ty2YxwVz6QXwlHQkjWf2b6
         5DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918850; x=1746523650;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRSEs2N+QYB/nkNFLgi0qjH35kXVBhyF3kuOSCE40a8=;
        b=IbggZZYnD0Aa7w7MEvGvB1l69GA06+Um+p6Gr7RLSNNvclXODkRFMfezE7WS1yhQ2h
         scjn1fgLlDkbYD7lwlpcSZtlId1yVl8ybLoAK5hs9mym8mhuWSjCPtiXPimMMKDvOJf+
         bgynxPv7qXmAUxBNhdyUyHLRJBjwTcEtWDTkCemiJC5tAO3/77eysJUyg+fhEBTzJ75H
         PZ0triJq9yK1LMAiGdPCDPzJgOn0rtP1KCzOwYk7BIRG1ph4hTvHxNiY4Scer9IxSCiF
         xs7BYu7mMwwhidRwYbtNayQs62Z3Y5f/F6OKuTiAdIFp6cqdPbbt3RKJN5BufP4hoBB0
         84qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHn2flyOd8mMsGFg5NymxVoIo4Qm4uXP9T84Ev9bPBduJdybXfxuq4Tl2Lp0+vTuIPE22+0Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MCpUdbAmBt6ep/vHy8nogX937awyR12OrwpKhqYa/az8xd0O
	4kQYAp9Kt/9P8r8YnemU6sIz6syB/Z7hA3IYYsp65jEeBddoAyrn
X-Gm-Gg: ASbGncsIlVuVmFNoFqUDRDB8wRjFduIjeVLwCe9mCOOatx5R4hIoqLPLTKZYi+oQGUL
	hlJu7uisL5KQoceY+CTQENekT3E3tsbIceSltPYUFsgt1FRGkO/SP2sfj4zTzEyoA3kEq4emBjb
	DX3KDcP91iV5xGenaX1weHj7fOsWoj50kGq3o8yfbcxUOI4xDI+lwm+q9r39P4dU1FoQgxELAkb
	yL7V5dR2YnSlVxdwF+1uVPh/D8QXOYRYbdUcHPkj9NNBhL1cFx5wxZI/uLncPsoUnqacJQeuEU1
	KEgxFGiE005meWDlyY/ASVMs7obEfPmANZb9iqKz3TMuLNuebZnEhQ==
X-Google-Smtp-Source: AGHT+IEWc3odO1qr8wOQHf32XRrjR91YYmx4xm2DngJajm3KBKQ1rkOqybRxhpD6EDSqrEjgo/QLzQ==
X-Received: by 2002:adf:f389:0:b0:39c:310a:f87e with SMTP id ffacd0b85a97d-3a0890acf2emr2358145f8f.16.1745918850229;
        Tue, 29 Apr 2025 02:27:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8ca72sm13139557f8f.4.2025.04.29.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 09/12] tools: ynl-gen: array-nest: support
 put for scalar
In-Reply-To: <20250425024311.1589323-10-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:08 -0700")
Date: Fri, 25 Apr 2025 10:48:08 +0100
Message-ID: <m2cyd0r2qv.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-10-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> C codegen supports ArrayNest AKA indexed-array carrying scalars,
> but only for the netlink -> struct parsing. Support rendering
> from struct to netlink.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

