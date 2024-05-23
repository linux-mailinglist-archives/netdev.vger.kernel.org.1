Return-Path: <netdev+bounces-97902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3238CDCDC
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948321F21B84
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BE6128372;
	Thu, 23 May 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk5GCNxh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3A126F33
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503248; cv=none; b=lmTRqqDrNCHZ9OntQy/9OXkrFBCWUy8rRyTQAJmjs4spro3oOAj/4oYs3rtTb9d78HubWk9PjXjXvr0wLgYOCHDcZCI1uDl+Y/SQkehFShry9QC/6DB2cAXCihPZ67dxNTPWra1SjgU061JH8VSxVzDyinwDvuMaUckZiBmGTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503248; c=relaxed/simple;
	bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnrQTp79Uc0zvIDwHSTMkYbGb31Nz1fO1Yy14woWZAgnASNOmUO+AH0pHFkrOhMqYr9xSWXVWM0UeogvVGaAUP/qLA/ZVAs+xnF/KN7nUNsRf7dvH0azufQn+CzXnsMQ/uwPZwWjzyfrsLIx57cf44zzN4fWJHZPjjK/7Nw7tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk5GCNxh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so12615e9.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716503245; x=1717108045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
        b=Fk5GCNxhPiar+UgjNqjnKxi3IrfdHjW+vWX1rl0MwDv2tlTs+VPfAHSQd1NVMLJ/oj
         WdBIQh9qnx7y55/v7xKhuDVIVtlQB8E7EoJtsOFq8HuCOAZ6n7NK4wOHkFH0FOxN109P
         sMmfcWa5GWHiOvEv/ub+4QWHvduAa2wQDvMzvrNyXgnNu0GUYRXqiZ+nQqp5I3//awaa
         Kr6byBq2exfk0RwXSaZEYeMouLmyq1HR8Bq5qMpzRkf7Hkfap1fxczP6PYxOpS89vMB9
         Fov9woabWfVVxo7QZrjljmf01fb6NERXovNLbGUXP7cLU+A6ImjpOekKQ0qaH5IJLmWe
         JpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503245; x=1717108045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
        b=NsWwMxbaNnv5NgvZWPW0Oaol8aESTcqYYUDyrusP/zfiSXUVLEKf9AsfqOM2+VaLTe
         bYskoC63iJmhV36mrgSbADDZjlWVQNw8X83tCyuhQ94o7HhbwSDxgzC1ty7MtbJeTpJ2
         truIC6uWkKHs/MwbHKd8p2YCeKcVbo4AMvlJrmlkQrxquoiUQfRm+oMGk/RhxtWaTqxS
         LRykg7UWu1sWV6jZFOSpR7USa1zcBDYEEi6LhAHsDGThw6LCk4jqif1rzQu+aWZXU3uU
         eJp8yTWx5ScIN/9Yb8MGDGpLhwI3BQChPhC4P14VxH1lbRLb+fpJx4NorF2MuLiVEY4u
         ISrA==
X-Forwarded-Encrypted: i=1; AJvYcCVGPNgmn1ym2uEX3K2Fn7RAIdMy272yoLzIvwW2wqBPxPXt8X5OmSimYj00WmolAwl21v7Uppa+RViW4Pr+epB7RkjTnwUU
X-Gm-Message-State: AOJu0YzyvN9mxwg4a9ACewq3r/FCosfrf/qnc05QmjbADWUCHpsJyTjg
	v9N+EA/yF0ufXkARe9tYvHBXW7RG6q1nZyglaJzAxjApB9c7VTNx31l7akTFfv/k1mI/uCgpjy3
	berjt5FmoFxaOvdF2MMfF/NZkRJVPGzLeTR1T
X-Google-Smtp-Source: AGHT+IFynCndXxQSRyQxEh3uszYlhUwS4moW4riJN/2gUPi0KmtIvL9iA7r73v9YHUvtIeizmNWwYHzCkJkFOKSr2sg=
X-Received: by 2002:a05:600c:3d8f:b0:41f:a15d:220a with SMTP id
 5b1f17b1804b1-42108625e09mr650055e9.4.1716503244634; Thu, 23 May 2024
 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
 <20240510060826.44673-1-jtornosm@redhat.com>
In-Reply-To: <20240510060826.44673-1-jtornosm@redhat.com>
From: Jeffery Miller <jefferymiller@google.com>
Date: Thu, 23 May 2024 17:27:12 -0500
Message-ID: <CAAzPG9MMHoHjR=EAAM9Rgkaih9QjU08tF6d8JrjQ43td=-oAVA@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	jarkko.palviainen@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Jose,
I can confirm that
https://lore.kernel.org/netdev/20240510090846.328201-1-jtornosm@redhat.com/
resolves the up/down link issue for me when applied to my 6.6 kernel.

Thank you for resolving the issue.

Regards,
Jeff

