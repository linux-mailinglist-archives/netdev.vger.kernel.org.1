Return-Path: <netdev+bounces-198572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38DBADCB9C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536091639DF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284A02E2EF1;
	Tue, 17 Jun 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AF34VXJs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98A2DBF4C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163483; cv=none; b=eopoi4F0IXGPG1BDLtgGFlGUnF7XXNQPC3GqyQag+czTHdbVrXNRZmW6HxaMoA04XFQCinzFMLQ1C7gvojktmjQQ7xumvVVG1hXbK0E8SDLIggYFrg9n7O7t3ou7VvV4AmjzI/R2bkR8D8g5SC+jgcrOY7+iTUlSLSNHKc/646U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163483; c=relaxed/simple;
	bh=3dUl3FwynBQpWRnlP8tcB6RIntT52auTEx8Ov42iq/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG/rAWcGHAzYPgptyg43FS1YRQlvEFzA9dk5G0FNG8UfBRll347IDymH+WbqcNFeUejv04WgcoFLPQjTxuZafS5LDFvCsqJpYHwxzHyi7PhOEe/cAmOBYRG+9WyecvWMWYNXFM+ZN7dbsg2Li5rERKdZfwW+kpjDZxxwHZSr4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AF34VXJs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750163480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KShC4QJThQfwPAvgTMBPmuZLHMXp5DkJgcjKi26gyHI=;
	b=AF34VXJsZ2DfLNTzS0yc5eZqAv1fspY7WDdrzSoJy1wIxtTSh6Mg97jI5zymZ4lCIEp28c
	XIfJQYNsRRroY+yNLxmug4JnhEVii3JQSYO+1/wu1zs/mHYrr4agqDnjE58bZDh2uDqtta
	GpnINJBZklulTYf7R/Xq7gHQ3dI4LuY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-958WW4EXOZKbvFaBt8kQeQ-1; Tue, 17 Jun 2025 08:31:17 -0400
X-MC-Unique: 958WW4EXOZKbvFaBt8kQeQ-1
X-Mimecast-MFC-AGG-ID: 958WW4EXOZKbvFaBt8kQeQ_1750163476
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2f4c436301so4134430a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 05:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163476; x=1750768276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KShC4QJThQfwPAvgTMBPmuZLHMXp5DkJgcjKi26gyHI=;
        b=LeaRPZCFPhcA/djcfFqNEaFBSkrPmohfGLOo8lIavsfLA30j68nDG6Jr+W6h4Gqz9c
         dZ3AHpsPhofQX32VaQswpYE1ICVzrRkGp81Iq8iyiCcW0pyJCzmJyEhrbKRdgG11DFVr
         oFsTKlTEraVEy4NiXclMX9dBL/QaYzD39BKdJ8gwJqYxU0cl6xNsi42tWGcOg0sJWibc
         zLKYKqGlEYT8gay0QUEErYxMS+jf9sehuAEpYZHulMEf4lvmJ4rhuH6pg8NLWRiSzDvq
         7MDmw3CuwAFxtwIXc8AY0Ofu2Q1t6HgPqL8D40QAPlLOAVkhLT4niAzdEjW8bSYbFaHI
         Tjpw==
X-Forwarded-Encrypted: i=1; AJvYcCWOFKTN0yoHQKc/hHKUsyFPrP22xngNrhw/z3+ICzXHy6os2mXoZyagau3TsjhQfIAtFpgMSP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcS28LgxqcL09qeSwJQdjKCR9LkU8w+rIc5pfieOnkTz9AOQ4j
	MAWXok7H0kgIk9C1C/gMh7Iue67Q9iOiogaQSVSuXKBSdXiW4rBeadrVeXJVSzT0oqKYA1dYyRn
	KlRVqKNCfU8m1pn3im6bliTW9nWvW9wcCj4P2jn0QbK2+D9npqNu44okVCQA6EKYYh13/9F+8Cr
	zN0S+HDfpNC8GSFb2exc7ZtkVZfRbCaUoF
X-Gm-Gg: ASbGncswdL7UxclMTy44hMl6IVPKnKnx0sDRdxK7CeotcawRtF9aQHAsnV8WZRqOm2x
	utSWVUA1PFS3PfDvjKJFhqcYR3tS2w2+Vm9uHtUP4RIFH7K/5isFsVAbvYPUdMxc6l3vsObxcIx
	dcjA==
X-Received: by 2002:a05:6a21:4006:b0:21d:98c:12c9 with SMTP id adf61e73a8af0-21fbc7fb787mr20024579637.21.1750163476476;
        Tue, 17 Jun 2025 05:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7HH4JHZZHWGn7WxI2rGQ/OeijPwRemStRDBDlQeXn02r9gXZyhyGGRph8cab5dQyPSJpmb9OnGFTrO6w4wWg=
X-Received: by 2002:a05:6a21:4006:b0:21d:98c:12c9 with SMTP id
 adf61e73a8af0-21fbc7fb787mr20024532637.21.1750163476107; Tue, 17 Jun 2025
 05:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617001838.114457-1-linux@treblig.org>
In-Reply-To: <20250617001838.114457-1-linux@treblig.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 17 Jun 2025 14:30:39 +0200
X-Gm-Features: AX0GCFtjoUlasDEXuV4xySiG1s47WSqTu3IKcqaRn-XCjq44bSF-f3FN4m8jITk
Message-ID: <CAJaqyWfD1xy+Y=fn1x8uXTMQuq8ewVV9MsttzCxLACJJZg2A2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vringh small unused functions
To: linux@treblig.org
Cc: mst@redhat.com, horms@kernel.org, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:18=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Hi,
>   The following pair of patches remove a bunch of small functions
> that have been unused for a long time.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!


