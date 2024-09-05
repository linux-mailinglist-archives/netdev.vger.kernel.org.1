Return-Path: <netdev+bounces-125720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3B96E5BA
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42CC1F23A9B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D519EEC8;
	Thu,  5 Sep 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlXkpPqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E08165F0E;
	Thu,  5 Sep 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575298; cv=none; b=jrWGbCFGn4lB6oM5e/xQqEZCgB+S8VzInLIVhWd3gIrEQARJIsMAZe4ceH+GgwcOa62YwppuNIgSD98sXxQcVx9Iz/fuU3KlQ2jeGHsqDZw75OntysREcCFnG3g01VdaRpkrFPSLFT1Wb4TMPe7Q/j8BgXG8LBlpR/TkW8cGrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575298; c=relaxed/simple;
	bh=HqJLEPQRqyYc4WZ5Djy3oHmPFt1Y0prsGxm0FnDznNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gd8i94Orn00Gyucq780sL5nFDZ1xE8PWH9IDHoPWnYOtyBCMCHTPPY6ODK4TbVsxLTDEcv3bBJQ0AeeLiDM6Dnqe/ce1BH2+yJRJK0ZbgToJcMY5U/5mzBW6cMW/ax6y5QdjgOICospxrdqKoyL4AcTrgcdbQoSkBYb30xzIQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlXkpPqR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b747f2e2b7so12823677b3.3;
        Thu, 05 Sep 2024 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575296; x=1726180096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRFy+2t5hJIKK0yUUXSog8G7TqOeTICVU5WXyorcUvA=;
        b=dlXkpPqRjDlRAhrPwAp/7KzcJegI9CokD4wVUgXWTQwpBgHRsajVFQCAzUz3GX/Wlq
         eTMClyDj3OUrQk1GU9tIRDhtC47QPtINq8M2d/wlzFxl892i2g51oBeTict6Gb2RxzX3
         Zrl5VNDg2hljJh2/RZdVVYmepwHy+t7naJzQSWQrOW8CzFJeBiSrFkjWp0D2UofqBgn5
         2NHSrq+La5qJsAYYl17M+PXcDwbSyhn3m4Tu3l+OPOp2/owaF1VVuCGaxiMRSyLf5bBp
         T7X0gOsP7r/ew/AcMxhTxqIj+tiA+Qd0Oi2yZBEX3MZXNTIwSc3BxoMYkzwC2JAfWPNg
         b0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575296; x=1726180096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRFy+2t5hJIKK0yUUXSog8G7TqOeTICVU5WXyorcUvA=;
        b=azAfQ1vF86xp5//mK4w5z7HcuwE+ueUk0kxSiN+FqzlnmkDCnXNrhTRHdKgY1ZPFMd
         jkMTmq9KTb/A5BkQinzwDfxDDzRgqHouIMT+XQC/c5GIJsrToU9MDU+iz+geZRB66uO8
         u4CFsjnJpXcpe+vsiojnUtLj+soArrSlDqq0poJ1TcCWED0Gy/dwjgcN3xoZMZc+5ntZ
         B6q3sxRz8cq7iiDSsweBTH9ui1Ck9LNuByoqek8VBghOf6lWNXsJgxM3KBQc8BzEnePR
         UHfbcbd4bYYr5mlCDTP8FKMSaIWrmjcmN2UzDjTQqXc2Ssmf4Cr0ffTB+RZB9XWBd32x
         VQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCVfJRbdc7Eu1UHbmrWRXnghnNwbSM3DA1WxvvszRXJ+S2HLk5CFWkQ9m0ASoE68M8BP2giaGCnpYHIZJ94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAohyZxqAizK4mO5fCrrJoQFJhXMsBE4JdyDxn+FgV9w0o8bVg
	GGJHcp6Spc8/VeOpEIc8nUIiGiRy3rbDFgJjzoIonlWF0FKzg/qymPM2I5cDeNA4gGN6srEA8Ie
	JB8sjsAvrKae8a2OYWjZrB25Ghqc=
X-Google-Smtp-Source: AGHT+IHsMWdgRwWZEaYT2iUvEZYuvcWuI/oQ7RVrTx5pczgfdpQ1VwQXW2HqkZM6zJLEsA/ny2eLMmudcV7sHxuXxwg=
X-Received: by 2002:a05:690c:7683:b0:6d9:c367:5486 with SMTP id
 00721157ae682-6db45273f5bmr7954917b3.42.1725575296348; Thu, 05 Sep 2024
 15:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905201506.12679-1-rosenp@gmail.com> <20240905201506.12679-10-rosenp@gmail.com>
 <15728806-c4cf-4e66-928e-b1dc7b487419@lunn.ch>
In-Reply-To: <15728806-c4cf-4e66-928e-b1dc7b487419@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Sep 2024 15:28:05 -0700
Message-ID: <CAKxU2N_gu-_aEOZ6U1wVF4D-qw9gCCe8-0VxNvJAu9aOTc0F+g@mail.gmail.com>
Subject: Re: [PATCHv3 net-next 9/9] net: ibm: emac: get rid of wol_irq
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Sep 05, 2024 at 01:15:06PM -0700, Rosen Penev wrote:
> > This is completely unused.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Seems reasonable, since there does not appear to be any WoL
> support.
>
> However, it might be possible to wire it up? You might then need the
> interrupt? This patch could then be reverted if it is actually needed.
I have no idea how to do so. Actually the device I have probably
doesn't support WoL. I'll leave that for someone else to figure out.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

