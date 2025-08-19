Return-Path: <netdev+bounces-215034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468CB2CCFF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA5E587E40
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8736326D65;
	Tue, 19 Aug 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSJaK/XL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3E254AE4
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631986; cv=none; b=dPmUeXa8L/EJFeIV5QM8XoFbnlMCCjN6R5sAgfbSp2vK2Kf/sPAedINiz9kQeh4IMsmmXgBAYJHkPZLnNJxlPRd7aWJqRj/4u7+ej+Q0Xuo4LGr+NWEx+0LnEoqJRoDNXLiHC0UG9zVnhrYrouERLZF5Ypbd6jdXu5psmACvhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631986; c=relaxed/simple;
	bh=Dlc+gv/phCrMNJTD7pA0SvuOLHUdk1RTYlblxps6Ixw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3zeKS3tsoJclw8bKDEEkpupfSp3nLkIy2J37crioIM9B4JmhNYTOHI17GERVHa+2Zb5a6gstCV8TNU36CIJc6SwITNciwdqIlsvIBDgDRNeudJ52RG6j9XwI00KxefAhZO4wmI+YztNTOxOrIgi0wUGlJOJ5l+cHsYhNpHJZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSJaK/XL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0bf04716aso90251cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755631984; x=1756236784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlc+gv/phCrMNJTD7pA0SvuOLHUdk1RTYlblxps6Ixw=;
        b=dSJaK/XLjjdkIlg8JnQYSU9gcXJdZATsA4dCEIJI3vfWY3BEVYPbTkQ90ZISFuEcGd
         TFgmrIYvuRRxusOa/Lh8s71TXhh65PXjFplPRipgty51jJW9zpN+Be+ze1RyixXxmOwl
         XKYbNfdySb1fP9vkrpKXdQpzZTUdULgGoR2ujho/yeKflkiOFcse7K6md9jryOc3iWCr
         ZeYFETYhXbq02CtDiwDFLRdbsXsztQsnp1WhNZplvp5tis3szI7yTBrRhp1IzsOfYfBA
         EzrD1xP/zvZ5KQWlxqyi6uHr6K2jNd0/dkgEBmQRl8K0DxZu3s8G2BSSpCv3DWTbth+g
         b3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755631984; x=1756236784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlc+gv/phCrMNJTD7pA0SvuOLHUdk1RTYlblxps6Ixw=;
        b=eqAe2kcj3f1o9p4G9Io2I6Y1g5XTYBscMKiODpcJZi1byCssbwXUVknog5jwiB3NOs
         NpHuIVjZSXZ+9NsC0Rc/nb7T3ME/ejidsWnsI9D3eJ8NV0KYqMqHcTQknB96bFlWnI4u
         KpclkED090TIdpuxvqzF18kemtReqptLi/cELLcdD+o7rsuy+dfDLpuaWMhlK8eiKL1Q
         VPj9azT6GfCmXfglMba6ANuFI3GDJ7xK+hxhIdM7OaS1voFWni8Hdn7+6Z2D+yT3eZpS
         sfztRSpw3MXwGsr0CQpCc8JC4lCr6UOEyQ3KZAowH82R9vZf6MWmEPKGoHFBvV1cgRD6
         lpkg==
X-Forwarded-Encrypted: i=1; AJvYcCX193awhc04eRAEDhEwVt/yZkYhyHd/SqhCQwxsigbrRszluq+jkVXonII527c3ubB5ig42TxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMB9AWdUZr6JCNgcivhdG/VWBrXhGnHF5k7cf4bIZJ+EyJ0dx
	LSXwhdIpUQMWQJ7d19nqw3KSJdNpdls67b+DBdGNBToCFsIBB7tAvDtck6eEvZbLF86XmZF8M2p
	brMRYNuBD8IrXZYuZDMv8AzOHp4Z6elora5jBbFKT
X-Gm-Gg: ASbGncsMcbfWU5mNpi60lbQ9XyyubWddr8u0Lt2ta/OW6zyI73rr53vxq1XBVtcgHi7
	K0MQWaP7dZxBrV1JbXRfnsoTCVvo54ixe+YY49O+/pBphghGmToy5s5kOyjgp/EhuGg+oKYGKxc
	/+wjmoyr9jzGTJDyH9DDROThywm+g82FUBAs9ZwPxRDVvqXeWPq6RdPtkU3Xd0XfWdvjQSPP9gT
	Di0VEzhq3GTSDGKof31YhZDuXmcWiUfNgTXAKnwims10psxUgR4SZA=
X-Google-Smtp-Source: AGHT+IFZOUs4HvSAXDicI6HRK+xenYcqiZRbzTDhlDFCbIHyzB/2YxgCL8t0otnlqVer1xfFluhajR27sxVEpthm9Bo=
X-Received: by 2002:ac8:5949:0:b0:4a7:e3b:50be with SMTP id
 d75a77b69052e-4b29190f742mr958271cf.16.1755631983445; Tue, 19 Aug 2025
 12:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <fab9f52289a416f823d2eac6544e01cb7040eee9.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <fab9f52289a416f823d2eac6544e01cb7040eee9.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:32:46 -0700
X-Gm-Features: Ac12FXyzzAHQkZQwTmfShgjuBIC83fo8ZLZc42_ORo6YGwvB1xgCyklsv26SR98
Message-ID: <CAHS8izMPCOp8QeC9zZddBYaGSNd-9+CtV7XbKOn43pHb03vi0w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/23] net: add rx_buf_len to netdev config
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Add rx_buf_len to configuration maintained by the core.
> Use "three-state" semantics where 0 means "driver default".
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

