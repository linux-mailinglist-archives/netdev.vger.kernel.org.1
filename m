Return-Path: <netdev+bounces-220301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A89B45561
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DD5587B87
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896EA31CA74;
	Fri,  5 Sep 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwu5JsVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45731A558;
	Fri,  5 Sep 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069648; cv=none; b=M0DSV5koTzWvBFmqBCpdUeAbEJE3v/gxFFB11BaJKDnrpTYOgHzqrHyfTxafx/cfGEpSJH7ittKrmEEKOpxHQ1/TXxf6sbeuLAJY+nrTBU1M+qyPoQcydP7fzcUsyQR5/hnGysVVQtRNPKNcHdy7JOLYUJXJdYYx8RtQ0KfqV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069648; c=relaxed/simple;
	bh=kKIEovFREh+RMQK1agLNyNMEj8+i63lgwl8odv/dpPw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=cY1sJhfPnUqjq+jEISHfPWGgX/ZRRjvjg+OWifB7/glGngODbXTqAsDQkfy+4Y4nuG55gplA4gsYcjM3lAy4Ccx0UR+U7XD7T3ddmeYct1GQo3Fb5M0ho5PfXSF1/HRYtWBtgRqLdlkwf6tB4M7wxPmo1n8WI9uvFzgXNTPb0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwu5JsVP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d19699240dso1849476f8f.1;
        Fri, 05 Sep 2025 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069645; x=1757674445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKIEovFREh+RMQK1agLNyNMEj8+i63lgwl8odv/dpPw=;
        b=Nwu5JsVPe+eEXPEwLwePIJAc3GZlEO5jXNo7lRDpYzqBpp7x6i80pbUYSCAJXaj/va
         bMWeK7ZyXEI1tJVxdK+XpXWV/pR85eHa/Fg+ck6UO6KHu3P0SLdYeeTTzHWGtuAQVv2e
         pd9iBe+ST+i5UIrumAT6bH8fXIFa4hWCKk1KnTDCpXQE3Q5gDoFw7GFbMfxfnIXqbaWa
         w3oylkZTv9o/H30LpW9zqhyjEUx563DyxlSMYT7gMkMBUOyEAq+vcRIMfQAQ3iVWW/26
         rgtOYdx/5etk6O7fZ79sHvx/MFWOH2A7c715PLauKUYb2urA3sV6K0GUiVP2HVbBxlJH
         pTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069645; x=1757674445;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKIEovFREh+RMQK1agLNyNMEj8+i63lgwl8odv/dpPw=;
        b=wYkKMh5EiU4oEMlodlbEKk7IM1s5qwEgLhehTH+rB3aO9IS4+SCPYF4sbEI2kq84SP
         cFhN4HtEQbue1b/9sTwPdhxgWfE+4yElweePBiXnOBezv5xlGxHNA/664JPv0Ok6NSvJ
         5UQcrY5xkSCPqp+4CIQuK6Hv9g3lP5tGE7fWaUHH6co3VGQJGXu9b0/txmyBSbn2C4Gp
         wWlk0Um/+URPrVNLBIyjm2gVgAIbBiCsEhpsPdPW5y5pI7991TgoGrN1XTMDRDbzk8qm
         3lNbGRMjm3Wsrvz48yvLPMdWPjlviZcDy7UsibZjsh6nVqchA7OmA/sH2K/LNb4+dlRh
         l/+w==
X-Forwarded-Encrypted: i=1; AJvYcCUREblsMNTpd35LuVcoxYONemClZqpEeUaafUWqJ9s8QYVgye7rnhToB8vq7UOZHTbVwJ5kPjtNvGBceB4=@vger.kernel.org, AJvYcCXInBEjc7fmcIk51c6e1KTulLDO7Mpt2BFTy5J//XplZfB83zcI4YBqCg3gNyKsM6nb7jM+uDVE@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8OAIwj5xwWDg7s3UunIZHSQOtKl4cPk39sRXAy7PTIZ/gka6
	1/sRqhVPEBSgcot/bOTkhS3foTmZbC6u1pN/AiQQrQ3Z+61IFsZ+L0F2isaMvQN8
X-Gm-Gg: ASbGncs0Q3m47VR/z7D2+WQ32xKZFJc4G4WxgEb2I4E6pn01joOyWFR+J75Kea7wcdl
	QNiOWphx7whrmol7GVzKDOOz2uR4+HXxJ1SXErzscSizcZiLKPqRJffdSrh5Ay+w+poZo4gXMfp
	9Hi8gcz/5c8uYoPoezaoKcvZEsVoeeYimWLwxWF38zO4u8HReeQElmny3FVT1W366oggwYAq4bl
	44pDQdoIAqrXTWVtXfjIqluBMNa6+jWnzxIVRgpI6ZNEZKch085VS0r4K65QDOtY+qlhXB2K14D
	dK6RIYdcq2g+VtkpKQ4ObmPJvd2h24rhEvX0gJQAgzx+SZGWYAse0jpUiS1HDHexnxUdbBfcnp9
	VNXfuzIXaYJkd5aNaM+7NLFcbeirVQOi0L9cJHvgM4oukkA==
X-Google-Smtp-Source: AGHT+IHxGOCnDwrLnrDrI91qnSsK6syMZ9DOdu1bcAn2K/11lIA4Xxelsfj+qwKYrbNR8DYfn66WCw==
X-Received: by 2002:a05:6000:26c1:b0:3c2:502:d944 with SMTP id ffacd0b85a97d-3e2faa20867mr2786820f8f.0.1757069644718;
        Fri, 05 Sep 2025 03:54:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm28607491f8f.11.2025.09.05.03.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/11] tools: ynl: move nest packing to a
 helper function
In-Reply-To: <20250904220156.1006541-8-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:45:23 +0100
Message-ID: <m2plc5xjng.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-8-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> This patch moves nest packing into a helper function,
> that can also be used for packing indexed arrays.
>
> No behavioural changes intended.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

