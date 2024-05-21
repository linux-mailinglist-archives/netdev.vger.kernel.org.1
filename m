Return-Path: <netdev+bounces-97328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD48CACF7
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32641F22F90
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11EC74404;
	Tue, 21 May 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFFOtlPk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898596CDC4
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289122; cv=none; b=UWlLQO/50izR7EyQvlkFpajVYltN4xOXsgJBp4y32XM6F93puAdmvtVVI3Pje5gc+Se/0YKPDEfQwSGT8T51sLJTP4VxwaTyrzbTcOWTGJKw9UVgZyGsVrU0iCRhs596cOaEz5VKgvw5fQsGj+WIccq6C7WU6wpCb4dhKMFsK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289122; c=relaxed/simple;
	bh=sS48oj6BasXkTAC+VORQUeUmUJ9WMY8uBT1xpUEniDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p0j4GUKP7smf8teu580UlNvJNIUS7TYKuYQk6GZdqZnrERFBUUvKlF+pBzl2hi1qbxPXtlWF9TEPuh65rL6sqxNhn0j8mbZy9g2AASeR8y2miCLg+WyQ8Mu/uXCamYMYxd2RACF9CgmgsSVcZ5HMNJMYr03fWNt5wCY78wgnX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFFOtlPk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee0caec57fso119013025ad.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716289121; x=1716893921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sS48oj6BasXkTAC+VORQUeUmUJ9WMY8uBT1xpUEniDQ=;
        b=BFFOtlPka/ZalZljwEVQ4fuUwrGQlCLcLkbQ1ztNNW5ktSsmFeYWhxOqkVqVdMp3TL
         g0gQLP1FTmgCHMKGNewDmYnmhNPAwty/CFQX0rUVVPr8gnCVfXF3dWLom3d+GLSzxxQi
         5OC8tZmZx99Cy9Cw7qnUBHvotMRjvIO0TbiM2q/37Z1518NPK2OD0jlfF2q1LhKB9kRQ
         M0DfpB1nreRZGjgduzd4qv1op0XOFBQ4WCjLh8uRNQMTK23M1BP7gqcff3ai/RGyBXyH
         Z76GqkiKrmo7VMkXFsGX7qCb9+Dgd31uGG1gV+NhtTf1R+PbGsfftchD6Ucyq14ar+bz
         hu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716289121; x=1716893921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS48oj6BasXkTAC+VORQUeUmUJ9WMY8uBT1xpUEniDQ=;
        b=Tl1sBhc+LJSZenfhpZDSWYC37zy6KlpFOV/Vv0D7YbIxyzt+ReYvjp7vwtr5VG8i16
         Z2Vea9zu4y4LFVR3cTv5gWVu4keupnTp1Xa0VFi33869ujpAdG6smZSTj4Wk6nPuwdl+
         jBu1/8cWfqlQIctUsQltNYSFuwnaP4cL3Afnat0eWZ5gI/PS2NjZip2ZGNyhCo+Qjgvj
         ldNMjqhd7c5plKRLKLXmAy4N57Fi3FZyW+ayNi8MHbE8lOBWyCdLrm1JEC1H4JZa9d9x
         yfJX0aY4Mqgeu6mctxZNCn36InMS5Mt8Whn5cnJJl08amfrKUVUEao6giy8FMyV9O0Do
         1Jxg==
X-Forwarded-Encrypted: i=1; AJvYcCXulekK+2FwOCSUK6Bu/wzPFzkSNKasg9nrcEcHgnRwhGb0JN5EcFYO/I9FWPk8kEtU+E65yNvIV8tpOQ3DVCgozVDZqaWT
X-Gm-Message-State: AOJu0YwXPBpT/Nl2NsU89/Xgkmw3D1IUFAOZT/y+q9k8yTr6+SknxqEd
	UijW6NRU8ud2qtvGOzV3JKuIlNKTEC/cX7+qImu1QsfpwGThVRXQDiWJuRknWQ6zTQ==
X-Google-Smtp-Source: AGHT+IHfcccLfgGAx8DfFzDXNJWCMb6UCPSobMN7oe+/U2JU6yVXqC9FHuCvFA1pp8A8C36jeXJPBF4=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a17:902:e890:b0:1f3:97f:8f0d with SMTP id
 d9443c01a7336-1f3097f9164mr3054625ad.4.1716289120763; Tue, 21 May 2024
 03:58:40 -0700 (PDT)
Date: Tue, 21 May 2024 10:58:38 +0000
In-Reply-To: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240521105838.2239567-1-ovt@google.com>
Subject: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
From: Oleksandr Tymoshenko <ovt@google.com>
To: srish.srinivasan@broadcom.com
Cc: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, borisp@nvidia.com, 
	davejwatson@fb.com, davem@davemloft.net, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, sashal@kernel.org, 
	sd@queasysnail.net, stable@vger.kernel.org, vakul.garg@nxp.com, 
	vasavi.sirnapalli@broadcom.com
Content-Type: text/plain; charset="UTF-8"

Hello,

As far as I understand this issue also affects kernel 5.15. Are there any plans
to backport it to 5.15?

Thank you

