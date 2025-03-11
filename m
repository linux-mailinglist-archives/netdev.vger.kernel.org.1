Return-Path: <netdev+bounces-173958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4239A5C8DF
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2F3A61D9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187625E808;
	Tue, 11 Mar 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/G+6qzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71A232792
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708341; cv=none; b=JeZJnutxdc6AGgDYMUeZWRK7T+1vLDEa48lJaKxaXFRmarXGbDe+azZm2c/ImG44QxV8Nk+8Hzs1iTqVvbVsO+ffbe439leuJb6EgljZRUziKIe64jywDtV42pFK2sEEDXC2Z28q1gRuF4/yL6nfbZug4HA1nroJLNU+RNsM++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708341; c=relaxed/simple;
	bh=FL53cvzxros9FXAXsrpO2xo6pNw4mdFJ29wILmBzP2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSblq1PAAvaIaeh+6ewDE59Z3xwBqh8PQ6anxGaoetWW4kHE67ENq/61Er3KyUWLbJmNeC0SOthU+F38yqUAEMsEg6KEREO3O9tJDhrr0Ue5gxeXNPhBthY5FC2LT88mAhYWZTAsFYz9puXP5klRxr6qvuzwwFlEHHdsYzg25pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/G+6qzQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso150535ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741708340; x=1742313140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL53cvzxros9FXAXsrpO2xo6pNw4mdFJ29wILmBzP2Y=;
        b=N/G+6qzQj9efsSOlzH2HUFvD/ARfDMV4YbVcVjcux7YJhL31LYz8HkxlikMgLkiNyD
         S7MwpI7+RZOYL3rJQvHGqijQZVIKEmpvV0zUcQalGixsbBoQPD/R32qZJtNFF85+F9Fz
         hR3m2MelSMtdeTW8ZVWy/bBbx22pdLu3tIf2GKkiUDRFq/1GsNlYWjtBl1TWGF2C2K0m
         ceig+ALiWR+zrhH900jXFNzS94RnMIq9gcV4OrjTrszD6LSZvyawKT2wHEEa7I1yiJp4
         Hy2QoVwWcId2wZSIjbS8hDxwVbPTFTsRPDHC+b0px1ldvmeNcJg8tVGpqDdwbR/THPvX
         BNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708340; x=1742313140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL53cvzxros9FXAXsrpO2xo6pNw4mdFJ29wILmBzP2Y=;
        b=BEC87fc0D3ojX9wbLlzfjFtEAqzwD+6XvidtDQFsGLgzqdHvE9avw0t8ktn4vHojxW
         NK9LwNDKbu86idSS6KCTmlS6dNpXWCTf07F5YbL1qbw07aNtsXKv4wpg6p4B8+chKt+J
         njh4LdeQJf+LwA5snVfs5zgiDz7PQ9k30AKn9bhT60PMo+BphvMD1dPYVO7Hr2FcN7p+
         HIRYoYGP+Gw8M1dqMotSb9F0wH/ypXStflliB+tm5TDO7S20zRf/edx71a8qCTgRGgpd
         epBuQvsEjVryMyc2XZtGvlINaCQB4VsghOWXtXMc3rHvHyqfD7D2XVm6SSF316Fg7SCc
         uWYQ==
X-Gm-Message-State: AOJu0YyeBqBX+aa0+NmtAKH5VApaRt61u6v/EcmmNy4eybPgCmf3fxBh
	aUjK1xidfyR5G1KkOtlHtYkTztxpS9rKDO4nCEU0O2qN6dvanME9DDAriwzebIyA/MtRavyo5Fk
	UKrCa/8rbtrDYAOJzko+ejID46pL+1Erm+Oq9
X-Gm-Gg: ASbGncvn3MpvpxyNfuRBRY5T7w93k4/tzzigzhDikVZdx/8IwhdcdlHSlOdrxKt3cXl
	I0q0IpkxTIyhAgFFjXMJU2+/EIKlEmBWaSllJfC7SUOWd8OmaClPAEcKa8HKiUpd4CEQvtbuPRB
	JRtnkSqCtpFZCKgr9XkeLv3egWFxENK6Lk2xjkQCZNiZlFEx62A0LvTVFt
X-Google-Smtp-Source: AGHT+IGORNmfjN5U27fWblEFr0gG9JaRpKciF0QGPID2ssgcD9GpVhPXzuylf8UVbONt9w4fBfj50ibZd+neI/wdTfA=
X-Received: by 2002:a17:902:eccd:b0:223:23d7:ee6e with SMTP id
 d9443c01a7336-2254779cf01mr7327605ad.3.1741708339458; Tue, 11 Mar 2025
 08:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-4-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-4-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 08:52:06 -0700
X-Gm-Features: AQ5f1JopsCMicSlWW9WEocdxT-Ij1nex7XG1znUoz_DTuz0IqRSEIh6IJu_Ad9I
Message-ID: <CAHS8izOFAhGKxvCR0nXq0Kdvz=2A1KSJ0E_k2XJ-X8wniNH+ug@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: drop rtnl_lock for queue_mgmt operations
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com, 
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> All drivers that use queue API are already converted to use
> netdev instance lock. Move netdev instance lock management to
> the netlink layer and drop rtnl_lock.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry. <almasrymina@google.com>

--=20
Thanks,
Mina

