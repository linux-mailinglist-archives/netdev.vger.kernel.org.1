Return-Path: <netdev+bounces-171918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E74A4F5F0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 05:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE67188ACAF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 04:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649021A239B;
	Wed,  5 Mar 2025 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+DZLSE4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AC45C18
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147739; cv=none; b=mwIDomqgTMWNdoWc1UO8Vsx0t8UrqT28g9KdFcL4zI4wZuKuIRmugeRV0Y+bsh43V0PCuO8IeQ4H3bujRB5EHWZ3cfRfG0EtoEPyzGaV9wqVT0dca0a0KuqHRz0GHrd4u0vlCQbWVNDv3pJ2GBf1Gxqa8mAX87dxHKkZfjiIJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147739; c=relaxed/simple;
	bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP5ZhX2M3ECGY1ncHY6+v46ITTD5INFh5p+w1pVR+wYl0DAqlh0e8yMzAIBBeqGjfpVtew5ztyn2Ea4UXfJJVCSvzz2LghV0I2dCtp/RcglYbaeaY1oMldrLf8JXAqKKq9nOePaO5wtkY6QCZOsqpYD1NQVOFzru0Jfwxd0Ev48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+DZLSE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741147736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
	b=I+DZLSE4RfdcBrChFqiV4COIQTCnFVvR6GW8D4sC9QnUZcBUQ1HX1qCFxCcM5PhdYVCOXg
	F/cJRclG9ex273VDLJzjVH++mJpNR+jcKH0p84T9oaYVY554qjAZPWA0/L1HWYZgWcfcBt
	VqTLW+gupZm43qmE+qzKAz0HALeHcws=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-qJNw3c08O7KtEvDg6z5IOA-1; Tue, 04 Mar 2025 23:08:54 -0500
X-MC-Unique: qJNw3c08O7KtEvDg6z5IOA-1
X-Mimecast-MFC-AGG-ID: qJNw3c08O7KtEvDg6z5IOA_1741147714
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so12342738a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 20:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741147714; x=1741752514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
        b=OxI947CU3VTqUPiqEfjpeh5tYzDG2gHyiCKNix/7UuRjel0tq08gr20BfgXVJ+sWJC
         Uk96nLfok0I17atsPcObQz4MinAvGVQ2BXdeYIt0rAmVP24CJojzJJESUW46821Tapyl
         GkQxsf8CzSXW30rvNnkLVKz7x/P4cTzkbyMJGyyw5J/vo4D9HhBFJhUQG6e6ZfDhMbp2
         PpiXTtxITXzTBAjE3XR4l3KCmcUBIVw6NOb6uf2a8kQESwIpdcdxiXoHV1SJg/Eoz+29
         W3Cfrvpex7a1dLXi3L/TBQGFhwDt7PhMX0wiTAnwUiF7n1rE2Apk/yzr7Oj2ftoxUDEv
         xVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOP5gOQwMsWtPX9vaKlpkFPxIg5Pg6ZHZpFiz3D2rhlKyBm5kyhhvHHioty8AwqwQSNgITsi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uVsSUZwPKkwtFmXa/2l9Tnt3i6r2uLg8b5Dbjx7enM3VpceZ
	u1nb+CUR/SoFCFG1enrXM7/phamDFEKaLjscTS54D8SC8ZsXmrLRyxog8SWqLGRzZih2+ymsYcN
	9diHYis0474yZShGe6ZNKEYcCxlGwBvcd++Q6At5MMy1nLVu93Da/s0us18ir669lludKaWlNb4
	Vc8Mw/ix6buAPvGrj+/sTw4aa6teF0
X-Gm-Gg: ASbGncu1pnK2BRnbKyUgMZnUtH/veLP1rYd0JQ9HWqmY2OUa1Xz7OZgauI9pvV0bCOR
	fgAc9PGGsj0+cLG7DlcysUVznEm1IFTQzeSoS+fhpArkKWkBd+mQyut9UxErSVzjrjCTX/0jNOA
	==
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2ff497a94d1mr3253880a91.10.1741147714159;
        Tue, 04 Mar 2025 20:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRhAjiy6oJgdTVYVOYk9K5LcroQa6MmEtafp7KA+t5KO8Pe7O1jHU38xtYt3z4pO+pz1vuRaGm1QENB3uSDNs=
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2ff497a94d1mr3253847a91.10.1741147713755; Tue, 04 Mar 2025
 20:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303085237.19990-1-sgarzare@redhat.com> <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
In-Reply-To: <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 12:08:22 +0800
X-Gm-Features: AQ5f1Jr9X3ymlwY6PrZDcvmZUstskG7PfMhNEYJbHpQgXjCqpakU8L3BFGy8d0g
Message-ID: <CACGkMEtycEX=8FrKntZ7DUDaXf61y6ZE4=49SmQu5Nkh_tf39g@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix VHOST_*_OWNER documentation
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:29=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 3, 2025 at 9:52=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> > instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
> >
> > To avoid confusion, let's use the right names in the documentation.
> > No change to the API, only the documentation is involved.
> >
>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


