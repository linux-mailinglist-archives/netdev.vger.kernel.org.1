Return-Path: <netdev+bounces-170822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FCA4A102
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF5188A750
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E51BDA97;
	Fri, 28 Feb 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XN+EDQ25"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A01607AC
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765377; cv=none; b=gxEZW8bgkVl6sTicmCjEWDS9aNVtlQhzN3fX++BY3gaQ7UuBHv3jQd1anOH8gsVHomYzRg7njRW8a7F6lL8MqLTkGGU8Vh0B11gevbcWspaRi0jflB9Z4ELrYFmmRPSyusc7VyO6y63YI/y+0XfdEhD0cqUAWT7035MzulkGJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765377; c=relaxed/simple;
	bh=5hRTl3r3drZ3yXZusZSc/icHJkO/HrAa3AEWepjTDtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJMOvKgkPUxl6+V14DnEPZm2Cf2Cyn6C51H4U4GGaqnL7hztC65AiFzsQUrOrB4AHrVwqcwUcRwxm1BeQWE3ShVFVdlGe/UpBWXHHux8mlZRcHYou/f+38Jc3OPJIiYf7S4ECvZ6Z0J9AWfJSlyKjN3/ka9SFRyDDhB9OCjtZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XN+EDQ25; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2237a32c03aso2685ad.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765375; x=1741370175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hRTl3r3drZ3yXZusZSc/icHJkO/HrAa3AEWepjTDtw=;
        b=XN+EDQ25+0zHNrEMzUWz/MiANG0JDOltiNxQBgnKOuF3sfuuBRImAMIC9BE5nt8Ciw
         Fh4Z9gclBZb7BkosIbxw2c9OMKgVcUkLGyJ0lcEcjsncb9RHW//0mAanPbDNKQxVo32+
         vFxvha8AwwzMoDcVE7mLQx0qj0F80bWDD72RgSEFqq3d0n111/1eEhBa8qt6s2eXuTKY
         FT5kjiusn5mdArDmukuU+LyNiaAM+S2YsEy6fBJYqtl8MVfoT0sJVBK2T0tGwb3r/jez
         /iELFkRD+t9UkfyD9lSF4pHquk2DgFzgAypbbK1nQWGPaoh+lOsCif3fFPtln+Fl7ZnQ
         SWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765375; x=1741370175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hRTl3r3drZ3yXZusZSc/icHJkO/HrAa3AEWepjTDtw=;
        b=hWnNsEIulr9tpc5JrqKrXYU2bxbEBKGgglg9YGWLThU0kEoefYwZONc6nJ4wj5FxOv
         DpL0Dudz802AuRpKYFeqy0iZKK72ByJnDcPFqJeSyxCjdqKSft8Fbh62b+hgO1x6jA3o
         vmU7sLxsBofu1ERu4Iy5rUCEgeNUkQI4DHObjXoi++72TQirKg3336ptT8e8x8mDTDgx
         pPRp8AT0l7YGaGyGOKrxX9w7AOiBOpCBiMS9q3yTb5oaJDl0vVPZ9mON26kW9OsXM7LC
         AHbWy8LU1JmXQzVmtJ19PR637Yi/ahWS/Ew9R9O5psqYWkGSdGsJBEon0vi90p135wvF
         FSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGqxPSreoM6tYUwatQgcdCqVk7oP49xqbTRvMr2myXC6/S5QJHKg9ocv1NZ2vVZ6+OmUWFYgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvf6riyRCfyucXL6koMg8Xv+SSNKH/mwxohjmIJ1dQgepq6+o
	laseRhPdXoVIveOMpRpkvQM0xueO41hF2q6CUK2uMWlyzRjPDgDYoHdP9vttDCzQ74gXPbzVwyd
	t/YXuQwm+msHU/IDq1rwDWt/39qpVzGTyZPWA
X-Gm-Gg: ASbGncu4yshlGyG8jkstMhGjTMg2W4bkFpQLxnfw5zJINfnmxvqz26e/V8Z5kTWTLAw
	Tnm4eOu3+g754K2EVV4ZZuSS0M8oT6uawRm51HhPuICHVioRTS/olzrDjEeH6D6CsFm3l71vdVc
	F6ZP8jEyONlYAWoBsb7bdtQP80oW0Q4B4Yt4I1mw==
X-Google-Smtp-Source: AGHT+IHvdnKescx2kw3tjKRz2tVygkrDpn+4ZfC4ReaPOfaumZ9avniHlNFfBe8qYKkmDTpQkbHQk317lMLV8Kp1TDc=
X-Received: by 2002:a17:903:3289:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2236cfcc5ddmr2648305ad.19.1740765374751; Fri, 28 Feb 2025
 09:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com> <20250227131314.2317200-10-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-10-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:56:01 -0800
X-Gm-Features: AQ5f1JpliY1V3t3crBxg2aKI_RrAsIU8HZYa7-xkZpdESpK3YJeqZioAsHB4XfE
Message-ID: <CAHS8izOL_ZGjN0nN_YTQu_py05QqDrYZvvU-z-Jv8RuWhfBUEw@mail.gmail.com>
Subject: Re: [PATCH v8 iwl-next 09/10] idpf: add support for Rx timestamping
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:19=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> Add Rx timestamp function when the Rx timestamp value is read directly
> from the Rx descriptor. In order to extend the Rx timestamp value to 64
> bit in hot path, the PHC time is cached in the receive groups.
> Add supported Rx timestamp modes.
>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

