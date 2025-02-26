Return-Path: <netdev+bounces-169719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82324A4559B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405103A98CC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EC267AF7;
	Wed, 26 Feb 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHk/zuPa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF827455
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551510; cv=none; b=Osmmmy88VSW459WeAxqH3SY9G5VlEtsR9e5QogW0JP+q/F58Si1zDk0K2R+rjlywhZUjfRNly6SxMUJ6ShcPCHv04dPR+cVbFY/zGWWTiHIRY9anCZrNW3an4x1zcwutU3Cv1tI9su0mutWVpKnTQATQxCsDEvXe0/38UWTc5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551510; c=relaxed/simple;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp3aEtpHMPMq3Dgu2P4JXjikZJspeKXor4Qc9/2JNlpodu8CjNwDRAt21NhUxYoOC8X3T0IC7+3EsB0GR3b/9Nb2wiScQaHuZtr7zBihqS7lVKLjQ6unoru27yfT1gi+iezrgUnIJ7rn7CScX7+cRrtlj5XzcKBTd6xcw/aNedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHk/zuPa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740551508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	b=CHk/zuPadTa8/06viBwSDDlU1nUZ/oS+5hxz6H4g1OkoxrIIcTny6DLgjAK5hbG4QWvl5E
	UHAjNQ7Ez66CxfFPB8rNPFr3VRAVH86B2A8HP2wI0wcpmKk4y+51D9l3CAhlvsuuInUHRr
	E/rmHneEOjY+8Qvf6R7Fw5Tt+FIsB9I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-jOGWfo19N_escK2GupSHGg-1; Wed, 26 Feb 2025 01:31:46 -0500
X-MC-Unique: jOGWfo19N_escK2GupSHGg-1
X-Mimecast-MFC-AGG-ID: jOGWfo19N_escK2GupSHGg_1740551505
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fe8c697ec3so129092a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551505; x=1741156305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
        b=ONBKE2F5DzJV1gumgTYZ8IKT1so9ZdMUEJyyqqCs/wOQ9ae7a9o3Yg0PGLlp0U9sQS
         YN8XU13ErPzuTHHy58E4397P29hQEGNkL2NSetxBkOsLgIh4Iv6bJJRKj37aQ3c4I09G
         O/Vox18CHRfP6ucuvNqwHXA5TScfuguaPl0vElHUFAljpNlSc6I4PklgkWUpeHaaNb8M
         UJTTioY5330U/03wr2VaqwqFZG31TpqhhVymBnQP+X2/ZNYWeiAyWN3kgvl+TvjynPxR
         YNPMm2/xfWkF0rLZ1K+HB6sGGBB4dBjxnB83YMBRirj67Il0G0lj49i6jv1TFCTN/cnB
         mA6w==
X-Gm-Message-State: AOJu0YxWCoJeBJf2IU+4PdNZllE0QtBX/LY88DnR4Tk2/wOyblFgY5Vl
	L7nOa7HZjqFjqYPZa8ZEndqJU/X/yasV0Kr1Ar4Sy+ipY8XqTf7gAjll5JUPGc4E4nS/jugMrWC
	cLG+58xGxLcDWIY7auLpMRGZ9HIm6/tYZ97lIOvEL9W+UDgywYLw43bS2uO9PHQM5X/EpPNG4r2
	G8VwrTAxtiSkd1DpZdGY8u4NJ/X0Vi
X-Gm-Gg: ASbGncvJ9mUpTWG6sci3HfCgw88Dz4pctDGCwRgt4Cr0UxqJihL4u6/moyOevWUs4H1
	QvFmhMfyc+g72YvoONErNyj9GSd6Lbt0Z3IIF0EThcgRjOLRkwOBtS9pb0FywY5vaMKSvLqWIkw
	==
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-2fccc117c76mr44400172a91.8.1740551505314;
        Tue, 25 Feb 2025 22:31:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgJ5uK64t8Qtg0HyTf+eyJQk/RcSifCuXdoxenxtpslxzpKs5bezA8wPuv+n2H82B3bP4YRr7ay+RtusUhlC4=
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fccc117c76mr44400139a91.8.1740551504951; Tue, 25 Feb 2025
 22:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 14:31:33 +0800
X-Gm-Features: AWEUYZnqLtwn7p8rdsbyWWPnxjSlaXy5DuVDq_eYBndkM_qofe9C8RC5AoEl0-4
Message-ID: <CACGkMEuoaqKB-4rs1QgsEU2rDn5s5GTJaL6jOiFj_TDSF2pC0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] selftests/bpf: move open_tuntap to
 network helpers
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> To test the XDP metadata functionality of the tun driver, it's necessary
> to create a new tap device first. A helper function for this already
> exists in lwt_helpers.h. Move it to the common network helpers header,
> so it can be reused in other tests.
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


