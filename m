Return-Path: <netdev+bounces-196802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDAAD66F5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E1B3AC286
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175C190664;
	Thu, 12 Jun 2025 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4kfd1zk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E713C81B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704055; cv=none; b=LK8Vo5U/QRRH4Eh+j+TwJBuiHVd03Lk9ma2mdapb4eXj+pG0NvFk/SoGiH+n8WfzC/Jmiw3N5kTQzPXBzY920+P8IPQ7nHrYffai1yJH0ivddtCwS+4YjtRySt5gKoheO1XCf258GBRck+H5SJq9L4S3D7YbJoAkRtpJl0qLR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704055; c=relaxed/simple;
	bh=l4CpCFkEPXhArGhHe83cXPQrO0QgByATLePmdZUTeKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa1GCCJGxcN0x1h0h2Cvi//5tZn5Fn4LyUUuODjVusLiR7IGa3SGs2x+weIvdWWuDcCdBi6+woSxjTb+rMDRYgrbJR5BqN8ririDE5wyWaNhVgMUyycyF9+V4ta9v91tK4OaOBq+qIAP/Wd6K67pqsl2E+bhVIt2uaCPWybaGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q4kfd1zk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2348ac8e0b4so78405ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749704053; x=1750308853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4CpCFkEPXhArGhHe83cXPQrO0QgByATLePmdZUTeKY=;
        b=Q4kfd1zkMaouobxcJRzKKiMW7dPz89+qy9Kxq+1zUUjVcJarwNReDWyzlIHHaIe85K
         6nF6FaCTaal6vEFsBor/3qrQbPtBWT6L+oxNJS79M+z3XSzRhqZwVZM2kKm0KjFxd08R
         lqBevYnwSMJCf9lRXTOkauj5MkjG8a+8WDZME6s/ZvXm3wJF160z4thLtKnC0ugam67Z
         1jzEaqqaIPe0CYrnGcqKuTYHUIVYICDhGrR3gRe+N/JkW29Px27vbIWtH2JpvFezxsVu
         7JMCEyYvIuMBCOlBkf86MjI3HmSABM9CAH74e/xQqI+6Py42PV1rG1DnxvTSrL4b7t9u
         dcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749704053; x=1750308853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4CpCFkEPXhArGhHe83cXPQrO0QgByATLePmdZUTeKY=;
        b=oqQtv1I/kFY9A3/oQyT0iVi3jXRcnwuuacSNlcqC1V4EC6OOiK7WLquJUBtLPdrxgi
         d5lsC9YMyQEL/Iyb1cHy6BzRUi/6GjvfGReXii7spL0ycexGfIDR3xv1qjAfTcDtixyn
         IvFiu6lF3fuQQIQHU//vC/gwUT1SVGdASp34waMlxOgLF1g3lClpl28W90WZxAkfNzXF
         k52QnvB54YvVKKWXAn6nZKj6gQR2FYrtYtQLcTfyLarzsWkOrRnGyh5dGZt/DAOQAArH
         CBNgFbJMgAjdcwPnx/OsTKPVA6VRidTZc81cGFqZ0CmGQ3l3ckJ2nZgq0JEq+A19aJPt
         9PdA==
X-Forwarded-Encrypted: i=1; AJvYcCW3l44cQKhevIkiQkavFjLQehapOlnIhOAVyAjsFuKlQmUNm+iBy0Ja6nj3+jf9WTnnKoydb6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMJs7hiJ5ytD5GQ2EMCLh9cfqtZUguFt8CgnarxRHcLNp/rKd
	tL392dNV0YpdwuOUk6tkL97W7fq633qF27MopMaUzZMBaH94qdLzNDoDhTlMQG9Qyo3Q+8voocC
	VazuzTNKazs0nUMkQNaHW7e7oheWomUEtMz5YsfL+
X-Gm-Gg: ASbGncshvif4uh0JChSrtOMsZr5T0nl05DCGnX9jxNJO6M+co9HhcNBXW4KC/aZzHV2
	Ci5Knqe1U5QTVteA9vtSZ5KnQLpIf2s8JUJvnz0TuMlIkWJcPtlDgY9Ma4pEoOlsX9CEun8S+FX
	CvuHpJYjHp+N8CFwjUO7KGBI88uIppr6jfsvi9OJoZxVh3
X-Google-Smtp-Source: AGHT+IEc4yvJ/9Le4p12BfieudAYYkFpP8yqL8EfRyMPHwRNm6LtkDe0Pch4N7grSHz8SvB2PpoiZJSPEu8nZuAg4kw=
X-Received: by 2002:a17:903:3bce:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-2364ead3babmr944025ad.5.1749704052655; Wed, 11 Jun 2025
 21:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-3-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-3-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 21:53:59 -0700
X-Gm-Features: AX0GCFvtush-ZCCdKGvUFlqRp4N3jBvWu7laru6O0slTkkxc74LRPuZDIkdxgp0
Message-ID: <CAHS8izMBTLr2ZVt9e3XZq=JNzHjbxLEXQCd+FZtN72-RowH16Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/11] net: Add skb_can_coalesce for netmem
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:11=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> Allow drivers that have moved over to netmem to do fragment coalescing.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

