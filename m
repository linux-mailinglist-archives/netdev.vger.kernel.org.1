Return-Path: <netdev+bounces-140788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49669B8115
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995B6283246
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7571BF328;
	Thu, 31 Oct 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkWMWtWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23921386C9
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395231; cv=none; b=YiVSzW5qKq9aJJrYcGfuGeg7hPasWKgJnPzjBLpT/CqlZDlZq0jQ8qDxkrkGREcBF2bbjObd5GlXGHoYBWn1L8g+xaLgF7YkN0mUqnwo7gvxvDkBc7M3SI17/OC0SQAf7X/Z9DnNvt/SFxAi1LGLx+XKp3zfj7LHg4tp3Sn8eGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395231; c=relaxed/simple;
	bh=Qpfn1aqERxQIIO2RpljK3QlpdUDGs/PQ+KjnHTvZPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skp2efpkBMQbiWytziaaAisZPafvrbXDzzEio9yaw4NG5K3ECIbTBjQ/hHZE53QrOhnd1ZX4oHKyMPrNXXJrTdntZ/Jl9x4lwhuvD2sgk48jSR7a78LnuiOTI6u3CdPejQfCk0zzTWflGO+3xd5T++q3WxRYKU1BnXqIYAWsY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkWMWtWD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e66ba398so1650e87.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730395228; x=1731000028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+rF3bbkwD/l4VpYrtWhBYduAyO2UrjlFMGIgBxxz8=;
        b=lkWMWtWD46ADG8jSwjfHnEmlVrrgNDA0o6MP2JOK85moVKiCMLk9+DwYBoc5vUypqM
         M5mpsiALO/I8YrL3Pe4+U5FpM9tbBlqBaI5TLpn4aNhv6COACGcZFgivkSAnVUX6Zb1m
         lDDuOYWaBYi/WqzKWF/s4CrD0SXEjsRg3VPB0NBPlEqqJ/2lasFxT70La5l7RtY8K+j7
         /uN+NyE/s4IW5Ewr2VU2PAE4z3f+SJ+iM0nbHpSpECHt+K7R8Yq01Uzdu5lB6Bg8UpQb
         VRAz634vKYXRMHUS7ePbhf4HhMsDVj1hlCa3E47zpGflO8zVkqkCqORQxN/tEvc6xVk/
         Uu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395228; x=1731000028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg+rF3bbkwD/l4VpYrtWhBYduAyO2UrjlFMGIgBxxz8=;
        b=BUE3EJAmiuPn+ylmOJXMh1dZ/FBPWEnKcbeL6qJ3mGeIr+7xpxG1CB9+74z5xCsXZB
         /OufKKyebfCRrfLseDmVSEcSblSwJGub/1yzpgW6apb4Jk6L8wzI+XGKYaPvWc3sREXz
         NKXHzqmWHe3udrDDmIW1je9YWQGTAbbHfI+u2ynk3LRyvU46txZb3D1KtwHdOQO+Vksu
         /MCacLUu3p2JiMwD7SsVpVtq7p97WWAWMnmA41Cw4dOEbRtuDriib92OHEw2St8Khsq4
         KeueVE6G9P/F9FlBa0elPbx5lm3JFDTp+8nDAeL4sFhNmklPR7CrbXsUQV3zZKm9QCtx
         FHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoga507H3jb2mac719FWoAh188nQ23hPlJGNDPO3fPEJi48KJgJrbDH2pYtE4kATKBXLcZ7gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBprXkVTAOX1zPFH3j/pEZwPo0pG/Yby4Iy2lBZwslOBU1tLit
	Pj0PnbRfx/lcmE+Kvrrk9TcIkokr14m6MmWoACacKqzugw7CFz+H5l601F6t+9ntk5/oaqLqjdt
	YSTWR+hjHmc8sTwgNOZmk8vGJ2sur2nMalP85
X-Gm-Gg: ASbGncv9l7+RDYQqpEaYYqUKM56xZYpIoMO6TsZU4hwYC4erp8ZawPwamHpj5VX9PaG
	HJQIZAvUbMMkp4kuDXJzTT+k075bBL7+SwUBSt0HF1GoyJyuqAxZPhohFdY4nVQ==
X-Google-Smtp-Source: AGHT+IEv90dd5q1CIH9Mt3/RPC+ncg8zHsWLi93i93FxiGZUohh8fnGc3oCrDv0I2EcVmSgpEDXcHBPyCl2iNQcs/7c=
X-Received: by 2002:a05:6512:4024:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53c7bb8e9f5mr285304e87.7.1730395227548; Thu, 31 Oct 2024
 10:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me> <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch> <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
 <ZyJSpBrhz7UJ0r7c@mini-arch> <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
In-Reply-To: <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 31 Oct 2024 10:20:14 -0700
Message-ID: <CAHS8izOUx=_HqS8foFoyv7H2d7zz6+jchG2r7w+LL9fq8CJvLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org, willemb@google.com, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:45=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
...
>
> Sorry, 2 issues testing this series:
>
...
>
> 2. Validation is now broken:
>

Validation is re-fixed with this diff:

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 692c189bb5cc..494ae66d8abf 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -568,8 +568,7 @@ int do_server(struct memory_buffer *mem)

                        if (do_validation)
                                validate_buffer(
-                                       ((unsigned char *)tmp_mem) +
-                                               dmabuf_cmsg->frag_offset,
+                                       ((unsigned char *)tmp_mem),
                                        dmabuf_cmsg->frag_size);
                        else
                                print_nonzero_bytes(tmp_mem,
dmabuf_cmsg->frag_size);

Since memcpy_from_device copies to the beginning of tmp_mem, then the
beginning tmp_mem should be passed to the validation.

--=20
Thanks,
Mina

