Return-Path: <netdev+bounces-231403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B9BF8D1F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419D142001C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1CB4414;
	Tue, 21 Oct 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Ahn+w5Ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F1366
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079997; cv=none; b=GCOP9EaG95o7eC53YVSVXJWgxbJrR1wTTxLiMR+yXhFn1r9d7Q4U5x+OvbtFh/3McpdSRoxlDQKd4nhkQJ+eIiBwzTWusyLSUyCCO/q6kQyN3W3Ed1WB0yffDlpDR87xZeU4iRB1FkrX75P+VwyGaTjhzCkaMEh0iBNDoF4JEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079997; c=relaxed/simple;
	bh=k/Q5bSFMzU5K91bGANkP3s/y6OcrteBW+TFDQ1SEsIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/Nsi2L2z2h0sxiXOo0iGeo3WK8FW7fDikHlGMOh2plzCeGPEvcRUB8unV1P1qCDG/0Kci8pVrPLiSGGM7rSSQ22wtSy4vrOQKNC7CwjWFhKMapWfy3O7VlC0IbUzGV3hz1VaLXoxxxltahi0I8LbOt/ToU26OOntkVgjA/TnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Ahn+w5Ec; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so320584b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761079994; x=1761684794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eknFTArCrsg8BHrx+M1H6G/8qzue9uqKfP/0s8rNy8=;
        b=Ahn+w5Ec+xcbE3FtTlt9876XtyGa9wDvbLNNR4VNKwaCyxXs05B9zAAc/D0N1Yc320
         q1O0FnttbrVi1pPIrsXB4NQxjyHm3XeIUoKT1kCow2ggmTuedwE9TOklxNsFbCeU+EZe
         a/+FOH1Gyou+24+DzRsV2MTFtBZaSAxeHCMn9fEBMNqpipbB277jL8CCXO1PG73xmvDd
         qKRHFYvwFv1t918vxkqWda8ru3IN4FA9CArWap5EV07atw4F/Y1fhYJRCpm8wRM6Lb9J
         /VQLJ750k0/eSns+lA53/87oGNIUUz9d/4YJb8xkP0ro5Bvnt7Pwhxp0hCou7JSHHlGA
         i9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079994; x=1761684794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eknFTArCrsg8BHrx+M1H6G/8qzue9uqKfP/0s8rNy8=;
        b=dR4zA+mN20LqedgzDIHz0Ogi5m1yWlL6amHJeNYmpksBMQVay02x+6kduq2/pEfLMB
         8JU0Qo5gTYw6UKdwN5/2O6gjdHzbD6WA39v4fMORZCE+pOlayQpiXFAyzIvZVlDfcesI
         a/mUCHXyynPJ696qxvxozT/r1oL3cpRXjn6iZ/GP1p0N3PPsKechOq9n8rO8G8zcjGi0
         MxIoKtwTJwqwVvTkZtSkanPy9LQRe4+SPCq7faF5q/Mt1SRou1g9dyqwC5Co+rOCvSbG
         KX3nDHU5vNFAtPliOfEesezgaO6IpC7zJvlbw9MnGXpV1UF/aFTpwxgrqov1xYjYCZ6I
         b5Jg==
X-Gm-Message-State: AOJu0YzrNewsJ6SgyOvFQcCewPLVJxlMvgKn3f40AX0LjLWuAZZEQXSY
	2shRUUN1IF2Cp4HvZh0x4RwAoG6F93AqHydAF3Zv5bV8eOgAy3j7hRLHsjvGJ9g1sj0UUI3svFQ
	7sG/fQyk=
X-Gm-Gg: ASbGncuRTTA88pyoyziz65wJLCpcvKT2aquWIaOCDnAZLRd+DpMJhBqnliLnQtjkOtw
	KhS2vM6dPzUTGLrEvagB7sc3zBAOW/8OWGpNQviFRMUe7ZKsBJj5BlXx3WFtD7SNQNW8Ephqhyh
	CXicekpuw9revbE90J0ww/hwID+Ph4k4u45C4gjk39njVokVFSXvAawHHM3Ht+LBPwJlBLII3Id
	8JW1Z1Y0LX+QqwoCUGOxeKfCSyRCJ3PhtCKhHu/EkLucHqR2EkQtMt+ahzJbC1q4jSjeX5M0AT1
	dxQ0DDKmems/azNznROLe7021LMaRE13pkYH+WAYemEQ12lDYvPWKMeJWl+HXZGeX4Ou7E50T7q
	fOGwurY1aCIxJE7MlgOyYhDBslhXHcdTGJTuhGiFqid8YqqQbhmuPQwBHyVq8xv0wps69qi3WBQ
	j8YbAWrWFHs7pHiCyJ9EgVNOaBUb0tOgldIwik+OBNz1/8VCiDPg==
X-Google-Smtp-Source: AGHT+IHCTMxtMQqq95gZnrbmBQWCBfDrQUXh75qMv48Fl+WxF9yLycjeByjGcuoduZozK9+rHKT1iQ==
X-Received: by 2002:a05:6a00:139c:b0:77f:3826:3472 with SMTP id d2e1a72fcca58-7a2647920b1mr1478374b3a.6.1761079994502;
        Tue, 21 Oct 2025 13:53:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff5d76bsm12209124b3a.33.2025.10.21.13.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:53:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:53:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] mptcp: add implicit flag to the 'ip
 mptcp' inline help
Message-ID: <20251021135311.4a97f991@phoenix.lan>
In-Reply-To: <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
References: <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 21:26:56 +0200
Andrea Claudi <aclaudi@redhat.com> wrote:

> ip mptcp supports the implicit flag since commit 3a2535a41854 ("mptcp:
> add support for implicit flag"), however this flag is not listed in the
> command inline help.
> 
> Add the implicit flag to the inline help.
> 
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

This is more of a fix, don't need to wait for -next

