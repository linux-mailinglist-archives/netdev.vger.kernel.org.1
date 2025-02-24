Return-Path: <netdev+bounces-168876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC818A41311
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4C63B5519
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154201DE4C3;
	Mon, 24 Feb 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZSIjvnS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE51DB34E
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362216; cv=none; b=GYbyZpxdwUpP1r+vCUYE4EpvSl5sa/HdKNZ6SmpcXkmErm+puiJ/o+ovARWa7ZabPYk66ecmu7ci/nnzWu+Foi8TscpQ05kObrrgtpXfXp90ZmkL9iZKGW7fdNokzWsU+xeycjaii3YMjThRhzWq44L31DHfzXwMuXHo4rJdZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362216; c=relaxed/simple;
	bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMsfPyTI5YCf3IobsheyFbAfWh4XoV07XCoCnPoCKNq5ODm0EH+WsiUeQUHfDJRQ+jDlUhSp4XuomcZ8sOReRYI2h5M65/FDpdoHSBslPDoLg8zRMwerIqMAZv7wFuPe3Y3vg9kP10BuphUWFTPOPZLX6CHbQlRLVmevNA/aIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZSIjvnS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
	b=WZSIjvnSiOLOnQZdA1bQlzQIxrlODPhzDehnLwdEIGTiizx6lruk88p99hZHn1EyAGtI3H
	wG5LfXr4+pAOX6pPWBVWfilLJfqicQEvhGSUB9bm4Sp3+UihH944G+9hZQolNd5dG/0TGA
	qSCoNL/l8nx7n9CYfJUTulqQIoPjl6Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-HxcB3qgTOIuPprtZxQFhkg-1; Sun, 23 Feb 2025 20:56:48 -0500
X-MC-Unique: HxcB3qgTOIuPprtZxQFhkg-1
X-Mimecast-MFC-AGG-ID: HxcB3qgTOIuPprtZxQFhkg_1740362207
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc4dc34291so7591484a91.3
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 17:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362207; x=1740967007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
        b=LVIpoXIkfmBUGhvbSKKyIbHfCQKnmeW5ws7o2CsKRSTXGPZ/zqJEqC3PNXrFqYPXbj
         9z8/ygjO+exzHsQt8nPpzHxqoTvA5E+504DSjaffXkfvSlchMRq2JgZA6TN29zXEbc/F
         NuF4yezWO9PtZIjPE/9lSvdkoq49UJsEsDPBo3oesjbJ3fUC3ypvegmywpCRKUxKnAYK
         O1JkKJtLskmnwupcSL6cjkLsllZAleFLogcAjUl/2V4VFPtN2W5YyI4ws9DmuDBDU5dJ
         Y7Pwkl0QJud3DnHmps49sMGQ2w1vRvxHkQD58dYwfLKgi8A2GHTRhv2u3lBsXg3CfmmM
         hJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVZZv9LQlAxVniSb7UWAE0iX/PqPdZbu8agIZ6QKumZVIhSxLgPhO6kpAJC4j6SOn1qBE2eqco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGMn/Igy3zuNn8vL1Kj+0gRrgisqjy/dh/SXnYxnvDMLt3b4X
	jQzgadHL9hU0DVVyLR8I5wIm4Uqppya3SlXMM1e8JNHLU1KLdaGBGA8AbJqMGvVgQTZwIIatl0T
	EptA+R/hiUF18dB+XxS7VJB88O5wB4wxYieDJIoPq0tdxh2w9VSPbbqYT5DxAVCCvzCnn0aS8Ca
	xdgEuSnUQVsc4u/dd+bYcRtw9jfNeC
X-Gm-Gg: ASbGnct/D4ilii/mJuuXqEqss/C2FAmunMHqLw/tqGDV7lgYwqItmZIdbk50ibaiWsZ
	SZrDpPymN3lUHwFyMSRzIpaiETzyf531klqxYtmLrlwqAxTvV+9WvwE0IV/vTKW59WxkzLo6oSw
	==
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-2fce78b778cmr19847389a91.15.1740362207076;
        Sun, 23 Feb 2025 17:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK9sEU4lgBSITBL7R7PIYPYfLCTP2jbN12H8uxVsQOHPrTrgk0YL/YWTUrigbXbtwUKlN+8N0guiwDqc1+JHc=
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-2fce78b778cmr19847371a91.15.1740362206706; Sun, 23 Feb 2025
 17:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-7-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-7-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:56:34 +0800
X-Gm-Features: AWEUYZl6ERtQHmg9Ng-G9gBzggonYtkd5NQ0JEzUKKMbmNT88IJbeaW3-Ohq2ks
Message-ID: <CACGkMEvf-WEuFUH7FwyM9w9Ay8qkz0edL3MHfGJa3CPkrzfm0g@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] vhost: Add check for inherit_owner status
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to add a check for this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


