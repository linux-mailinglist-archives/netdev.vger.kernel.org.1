Return-Path: <netdev+bounces-199146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D3ADF2AE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BAA3A46AF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E912EFD94;
	Wed, 18 Jun 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecg4+6Cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EC2EFD88
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264110; cv=none; b=TG9InDt9mT9qfLmdKbq9KYaj+r9JPK9D6XDLk2ShgdDgr4EtE0LYW1uVIYCksiUFurcyFedw0GiF6R+pZrydO9KYI/cd4SrnUyk65/6l86jUW/MAIDA+oYSfUkqtaDOvENZU+TsUFjKT8UxRIJYQmS2IjB9HKjO5RyelZ5eKy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264110; c=relaxed/simple;
	bh=d/AMqxO4YbHcFUQJYbaZHeLdfytsdxhc45SBjMrf22o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdWNzjKGzIvN5XxbTp1dJq9/dPcPpI0k4qjWhFa+MFmnCqWRFcBDigUPqLUpPOW0JyuoqVXebeLJc6ooymJhTrm2XsB9SM9P0ZvMhRTsLtuoTn/Ex5hQIaUrkF9oz0j+Iw/m54Krd1SVgAp9tM4mR1v7faoQ8u4tNRjwVMgdW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ecg4+6Cu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7486ca9d396so4568587b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750264108; x=1750868908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR36hsGKjdUH7SouiBSZB6/fkb/EJsjtv0c3ChSD7HI=;
        b=Ecg4+6CuzXeg0TyfqX6jnWCVcQeK74HkQCUS21sOP1Vp2K+6LHv1ksWdtom1U8UYam
         FsJ26RcLTHqfeaJwvudEp/f+s2eTbBaZnmv36Gt+KyQdcjasuL/N4oGuUCBroW40Td2+
         qqv1vJ4UZFv1GBIIZpzyUhuAeLdkvodHirXbTu70sGDJFAiWqKdM+2gHi90KmM4swvp3
         JgyLRjx9SK9zoxW2E0d1VfnIe86RNjWEe9wk757HG6p1gLpBVyZq7GtIpf+P8Z5ONK0w
         /zvvtFmFGq4ZNtWQX8MmnpiymRXBTmjDIv0hjp/4Tyfl+tct0vQGdBS6pY2LK5EhfDUX
         cdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264108; x=1750868908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR36hsGKjdUH7SouiBSZB6/fkb/EJsjtv0c3ChSD7HI=;
        b=U4QuoFpFo+FXRP3y07QhKwK5n8GoygKKw2F7BMeu3cz8WZUOeAul/SqXIpdAONjRY7
         YjpJbvRifS5g1g0m00sdsmwnl8CGNaJsaVzOV+CGlAqlke9MlbzumiRY/fvHC5wxAVkh
         9+vVKASnIC7qm/M0oXOCKrX39KjsCoDNOuPeB8X4cqyp5hfPKjJVOvGV0i6EtllUfcDN
         TehUOld2Zhe0NDYjchg6ivdwzLxcv+/gMRbt8xnoV3Y16+LVfZh8J+nh6xH8usPcbde1
         GXKGvgXK837UmCMD3lfc5CMyyBMOVFDaRw4DZE+srKrYyqVjyMCN0lV8pddvwmtO2C7h
         H6xg==
X-Forwarded-Encrypted: i=1; AJvYcCWOKYmnd6bFMoXrClLYM+W/Yy90VFnl7P4XJTblYRhkt9g0jIgFyp2dAOlm17h4NBrPjRFBfMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5R3FJL37/5F0uxqVRPYI8MlLB/qd5gbQ4xmAbpZgkWhF0JzSA
	c2HtmPGjuZhCxAzJnzZj41IqmQQrJt6JJLhj0qDge8n5uQqryeHEZ8I=
X-Gm-Gg: ASbGncufZMtmC8ZFmkD+YRfmh4DlURGWTOpBnsLJrVbLCFid9fPALS2oY8aAmpFP5nX
	lkdSvwXoK+2xA/TKPVGMIZP/6ZfDFWYx05E30nspuh6kzePulcEjmAeYmjst2UB5DvafMy4lxbH
	f63sK92oPItJRhRciCsGLXlLyAb+02+VDc3cfax2snIwO90d+EuTcXrolRulmVAGe7yuz18lify
	GWdyIzBbz556+59KIaca8WW7MCEOfOeVLx9FuVCQBiZhCwCuieKIpStIch5byF7PdhHRo0JUwBL
	3NDWQegmffG/wCIjUx8+2PdCLX+EkxK58V16pXA=
X-Google-Smtp-Source: AGHT+IHEQOZ5PY7QqL/7/MlHqZh1Ad5uzay2HWFTAUdBlMKOt6lSKkwDU+t5CIQZt9l3L1oyqT+ryA==
X-Received: by 2002:a05:6a00:4703:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-748f41d6d3dmr1044706b3a.4.1750264108141;
        Wed, 18 Jun 2025 09:28:28 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9c6sm11242107b3a.9.2025.06.18.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:28:27 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v1 net 0/4] af_unix: Fix two OOB issues.
Date: Wed, 18 Jun 2025 09:28:21 -0700
Message-ID: <20250618162825.724112-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618064126.2cf21b31@kernel.org>
References: <20250618064126.2cf21b31@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 18 Jun 2025 06:41:26 -0700
> On Tue, 17 Jun 2025 21:34:38 -0700 Kuniyuki Iwashima wrote:
> > Patch 1 fixes issues that happen when multiple consumed OOB
> > skbs are placed consecutively in the recv queue.
> > 
> > Patch 2 fixes an inconsistent behaviour that close()ing a socket
> > with a consumed OOB skb at the head of the recv queue triggers
> > -ECONNRESET on the peer's recv().
> 
> It appears to break the scm_rights tests, including a UAF.

Sorry, I forgot the length of a skb holding embryo is 0, maybe
sock_omalloc(1, ...) confused me.

Will fix it in v2.

Thanks!

