Return-Path: <netdev+bounces-247951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E13FD00DBF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 04:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1933030DAC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 03:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD2285041;
	Thu,  8 Jan 2026 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5BuMgMz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpMUZfdi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87255284881
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842609; cv=none; b=LD6o/SK9119zWrkpesNdl6JQC+onODIpae4V7WAlYtzbGS79hzJxUXr0/8sngE/AmYqbtUHSxG5BlnrupcJXBVtvBL77jtIKJdfR1HcZM3X1aZXpfMiQ0JtjDMP9l1n7LslR/WKh5JMTpQxuf2W5QMiDhyrn52vZJRCDoPv7uPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842609; c=relaxed/simple;
	bh=oIv7VTewxFjssL2jhliOXXbBPd3GBbrqXH5sFUlQGGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1Cn+TaS58jqVMJgFvwDoSV9zSpXaxnqvGRr8Fc9ZqbQAOPJ/+3cNyvk1V3bWgIUYfvzgX20uRS+cPcC/lSvuGx+11tJULEy+nehvmYJOHtLsE/rHnHBET0YoHCblC739vpaafSKKR64O+txECBcxqykChqxxyxwsWpVD9J4JHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5BuMgMz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpMUZfdi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767842606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53+r2N7iOHCghDUQ95LK593uOrK3zjiCULW2/UR+Mu0=;
	b=P5BuMgMz3qipG0lldGfymzYfiPt6pDlAz2P4d4lzx9KOwljN1uWqZbzlVCHprLA16DMgeD
	FZSSJmGukvX2yEVdQlddE52dXh+9fPno7EA/8HdL+MBc4MHKuVMyHFaQXP7QA5uH/id68x
	Ji6YahO7RiMrSaOnu5SzBGKRBYLPthc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-hKI1BOI2P6aunbpiMlrJcQ-1; Wed, 07 Jan 2026 22:23:25 -0500
X-MC-Unique: hKI1BOI2P6aunbpiMlrJcQ-1
X-Mimecast-MFC-AGG-ID: hKI1BOI2P6aunbpiMlrJcQ_1767842604
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13cd9a784so25319725ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 19:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767842604; x=1768447404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53+r2N7iOHCghDUQ95LK593uOrK3zjiCULW2/UR+Mu0=;
        b=MpMUZfdiHCHYgyEDJke0d2yoflRy4awn/T05siz63do5UByQG9AU5BwD8PWyA1K9/7
         QufmnjeQGMq5dW83Pzcrd9cuSgum57+8yZJHbc76VDsBCa+FJx+3KsAGvy1VGrMbgM0W
         C6Tl3M1N/i40nFYngMsD8tlpo6yZ5X9hZsPneqFx255IXH917U2Dw1D1pUKlG/5eUqmx
         l1i5xwjlntMc3aUATHrOnHXu+WNFzQQdUZNBeDnPcE+5QaSVy7+j/1cC1jbjoHjrShTg
         QiVGBLkP2GPC8XSp2d99PO9DPS7d52k6fmd/ORgjMNw/l/UXGbizI0zBoTNOB7bhnF89
         4dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842604; x=1768447404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53+r2N7iOHCghDUQ95LK593uOrK3zjiCULW2/UR+Mu0=;
        b=p4zrcbkNVhtIARPX/vCSS/GYIi1TFL4ikX2wHq7IH9yE/NUQ1RxYJOnzjGuw9L/GJC
         jpKvHSFEmM8mfm91MWjWVM++Co+LLf+NKyubDNXosjfuCl2JkaGfsvojy3QADePUa16+
         GBr+748xNEezmtLlkmFZEosoXrOzx5wf8GtXL6V8b52YQqOBTXxmya2HzoU1e3ZqIgJR
         /pkIVs6IkaPE+7duA+GTkLHSXu398v5IXhXhwoHbph/+chG76G6wpZOOrA8oC3v8RKP+
         CuzqSnVVIPFpCaUUbLFcM7PJuYvlk9jhiKAJ7I/4e+Bda1gnUS+2K4V3yQWxH3b0GBcK
         MvJg==
X-Forwarded-Encrypted: i=1; AJvYcCWjX7CKOfuElWa3OXxR0//2DF6unSjeM/7MKHc+CJfP0kISmyEuL1IMnm3s+nV5MT+UBsRvcI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vfIdWs1no2w/+QTc/p/Hpd2J+OmRM+BGQoV1awqv1KjAZlUI
	wIJv8XvNVzdCjL3wp5k5x608NGSvMoq1y+YQypb0Lov9fbeo0TxlY1modHROVHbxMXEzvrkH9sm
	h7C3IV8lPnXCa6iL5j/AEZPn88oYr0z6jwzOyloatw8PcAyVZO6p2fgA7fzZHzXGk8H8mcLdz23
	LUMuJgOQ34l3OKz2tpPcntWyaSx/pKeFRT
X-Gm-Gg: AY/fxX6piRDPwL7MhoUQAIkvY07EDDR99bsugNGpDjtl8x4jqhYyVTckhBbaFqtlaqZ
	Nl/A4SKjLO86/oZGjOYwtjG5PBl33q+1VMp6YyGZ1RekVjNVsf6g4uxGFPSNRylrHNvVJ77zgNn
	hn4lfo3lSeq1sRcLKQDGb9rs/yL6YBRFrLBWUSVsZdS8nXDLyFHS+iLDJqwl27wL8=
X-Received: by 2002:a17:903:41c9:b0:2a0:a33f:304c with SMTP id d9443c01a7336-2a3ee4c0025mr47651465ad.57.1767842604055;
        Wed, 07 Jan 2026 19:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRtayNY0uqqjM78CiVQw7mFTLxT/iYnZszpaOrmD2ynKaqKve+vos88ChoY6cZhopiJ0fw3kSZsdEyMLVdhzw=
X-Received: by 2002:a17:903:41c9:b0:2a0:a33f:304c with SMTP id
 d9443c01a7336-2a3ee4c0025mr47651025ad.57.1767842603302; Wed, 07 Jan 2026
 19:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:23:10 +0800
X-Gm-Features: AQt7F2oDKZ3eYcdC7fFyoqIzzMdHxzeD7csgTVUKHz7k-5CronqUpphVIiXmk98
Message-ID: <CACGkMEsHxu_iyL+MjJG834hBGNy9tY9f3mAEeZfDn5MMwtuz8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/9] ptr_ring: add helper to detect newly
 freed space on consume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This proposed function checks whether __ptr_ring_zero_tail() was invoked
> within the last n calls to __ptr_ring_consume(), which indicates that new
> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> the head - and no other function modifies either the head or the tail,
> aside from the wrap-around case described below - detecting such a
> movement is sufficient to detect the invocation of
> __ptr_ring_zero_tail().
>
> The implementation detects this movement by checking whether the tail is
> at most n positions behind the head. If this condition holds, the shift
> of the tail to its current position must have occurred within the last n
> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() was
> invoked and that new free space was created.
>
> This logic also correctly handles the wrap-around case in which
> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> to 0. Since this reset likewise moves the tail to the head, the same
> detection logic applies.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index a5a3fa4916d3..7cdae6d1d400 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(struct=
 ptr_ring *r,
>         return ret;
>  }
>
> +/* Returns true if the consume of the last n elements has created space
> + * in the ring buffer (i.e., a new element can be produced).
> + *
> + * Note: Because of batching, a successful call to __ptr_ring_consume() =
/
> + * __ptr_ring_consume_batched() does not guarantee that the next call to
> + * __ptr_ring_produce() will succeed.

This sounds like a bug that needs to be fixed, as it requires the user
to know the implementation details. For example, even if
__ptr_ring_consume_created_space() returns true, __ptr_ring_produce()
may still fail?

Maybe revert fb9de9704775d?

> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r,
> +                                                   int n)
> +{
> +       return r->consumer_head - r->consumer_tail < n;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FI=
FO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> --
> 2.43.0
>

Thanks


