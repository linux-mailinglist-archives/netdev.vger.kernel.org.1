Return-Path: <netdev+bounces-151186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5489ED3FD
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28962830A0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7B20110F;
	Wed, 11 Dec 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="iJ1Rv1gP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4951FF1CB
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939215; cv=none; b=t1PSfA6o7L7O8kb2/ayU15dNJAKmEW5bIxln0XdYPO+x+ORRcvWRPIXWGMrrkvVlGdYQTf4dD7pcNAL8Bg8oMsxtSBUvoaoNUeDZsS6n0ikNFAkVjHS7drE4qv5cq90j4a1MvU+0t/WhZ04Bj5ID8J5EXA6NgL2W9jazfUWl7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939215; c=relaxed/simple;
	bh=xKfttj73jG1uTZpJNN82RMi2jpdXNIkxOf7nv7eMMZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asXImXpAh4hbDg5LKYJvOji8Zygo6Pzom81j85Sc3G8dwcgAPaPhEb/ed3ZOwgIUggaszx34QSl/NjNVU4XUuBOYhaAxwbp+oF7cnOlnPAJ98b4EfvSeocVhWHXq7mvXtBIuAhvMNAwzSuzYmSc8t3s6hB0OmrG80RLypfJUPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=iJ1Rv1gP; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e398484b60bso5665559276.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733939211; x=1734544011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XX4yF9JMGXX3II/VI0ICz4h+LN+8Yz44eu6TfJ04Ugk=;
        b=iJ1Rv1gPyVXZinfE2j1hskrQVtwOTmifZx892vfPVXmW+A4luks2PdH2B2Tl4HOqN6
         U9LqS7pYhhesWy/EGPUEEaXNixUTWci5GU5iiVALQSIcaGNrrwa3KRwiY7NIu2Xm5M9O
         b3bR1JInOlALvNN3xwW/FiAhOLXRWEdfW4VOahL/Xlyp3XRxMh8RsYIj5yDvN6DZJ7Ul
         iOh4z0HBbsY9FYf1yBBSENjuPtqUFQzg036S66WXVQnVehFi4bWC3djajWjWbKhxsi1b
         JZ7nHrGpMISaEuXqGNuZ52zlgMmrRhLWgeS7Sg8Hjg+/P5uGHHslF0Tnhj90FCLu3x1z
         uF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939211; x=1734544011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX4yF9JMGXX3II/VI0ICz4h+LN+8Yz44eu6TfJ04Ugk=;
        b=nKU9wxBuDbXqE8t0qwzsVnfGwzFejc/R7ANqV6uZMQ4acZO3ICY4fijjGmrxf62+hz
         nwpJLVnUKUC661od6WCiuDhLlgI1jYBxoIyhkq9f9PnkPygw+nzCyuvOvskCabQLPC1O
         mQibSrJRVtiV5qCGDW/QuEFiKOeLEMbGaqvtFh3/qf/ZCNMSxbgqqg/AZCjyhe1nm7FY
         AAC9OZ6UlpxKD8JDKcwBPAidNCEkrZSngpUZOaHLaYCUx4EKmdDlVvBjezyXCTSrLUqB
         eEpUVMFqG8CCiA9jYOb2EitUW2uyLX9NBzRxlBPpxzS2oHxgYZspPcF/VsWpIuRD/TQf
         5oig==
X-Forwarded-Encrypted: i=1; AJvYcCVILcwGKCoA1orn4zNXz1ZT6JeJhmdqP+G5SktruDCqrPuJnuPoE/n1SrdDcg2P/xlBm7DaAXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbMNGZmjtKoJzCr9z33NU6N4pq6j1h7zmo2f7xdoha+X8izzc
	dBs/ACQA2Ae46Z6RYx5C6Po1jtecyuxedmSCqrinucaLvz2XCpLZRvWiZ0GV+LEw+VpzKR4Jxo1
	sW7igL+bBZCQaXm/5W03273v3nroSFlhgV8XvLQ==
X-Gm-Gg: ASbGncuc4+N/th20PZ49xZISVXmUwi7bceVsoMsHkg2R5TQr9hDnRSq2BTd0w5nM0oo
	0Or9dCRMmJti7SYkwxrNpMzPIU3d0yMgbJ74=
X-Google-Smtp-Source: AGHT+IG3lDp6pcc8WpN9DOxtNpymp29steFnShZFR78LeXrDU2v7lqz7zSz8oGrhbnT8m3jrCYcj2LxsZTVFVNmSQds=
X-Received: by 2002:a05:6902:230d:b0:e39:8a36:5771 with SMTP id
 3f1490d57ef6-e3da3158089mr228005276.34.1733939211006; Wed, 11 Dec 2024
 09:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com>
 <20241210-converge-secs-to-jiffies-v3-16-ddfefd7e9f2a@linux.microsoft.com>
In-Reply-To: <20241210-converge-secs-to-jiffies-v3-16-ddfefd7e9f2a@linux.microsoft.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 11 Dec 2024 17:46:32 +0000
Message-ID: <CAPY8ntDHcGpsaNytY2up_54e03twqZ2fj1=JTnb8x7LLo3uGDQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/19] staging: vc04_services: Convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
	Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Louis Peens <louis.peens@corigine.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org, 
	linux-sound@vger.kernel.org, oss-drivers@corigine.com, 
	linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:02, Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> index dc0d715ed97078ad0f0a41db78428db4f4135a76..0dbe76ee557032d7861acfc002cc203ff2e6971d 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> @@ -59,7 +59,7 @@ static int bcm2835_audio_send_msg_locked(struct bcm2835_audio_instance *instance
>
>         if (wait) {
>                 if (!wait_for_completion_timeout(&instance->msg_avail_comp,
> -                                                msecs_to_jiffies(10 * 1000))) {
> +                                                secs_to_jiffies(10))) {
>                         dev_err(instance->dev,
>                                 "vchi message timeout, msg=%d\n", m->type);
>                         return -ETIMEDOUT;
>
> --
> 2.43.0
>

