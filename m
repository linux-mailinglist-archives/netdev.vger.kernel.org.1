Return-Path: <netdev+bounces-182252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE3FA88572
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D3419054B4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60D247288;
	Mon, 14 Apr 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBbBEZgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B723D2AF;
	Mon, 14 Apr 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639866; cv=none; b=qw/xBGJcke7Th8wUoJnRWHTk1g4cyPzJuZa0xbUzdjyoiVAhyuiNJjNCrpCVJZPemtdYPiDBVtFb5HVOtWmKkADR0c/+++cd8nIeOYSpifG9JSS6QcAqNrvJGrjK2vWtq9VSE4W/oGbfDPZXTsz8g1So7IXcLPgETlKAyDx8DxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639866; c=relaxed/simple;
	bh=2UF1+d4niNyOW8VA+r1HnFvlvMrBYZBQGW+6Ol6wzTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlBh/kyw75YekILOkiSORSRmIYgJs25bLrLCRFqjsqbvq4LfHeJbBpiaQMUcbPuh8dznqLYEzKMitZrZ1lh2UISRdH1ubeb+347BgmYWr803Pp7sagSXMypR2vfIgNHUiQlapa0QMJ+qTfHlaOqVa3j94CFEL8htnHaAcdUbvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBbBEZgz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so860975966b.3;
        Mon, 14 Apr 2025 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639863; x=1745244663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UF1+d4niNyOW8VA+r1HnFvlvMrBYZBQGW+6Ol6wzTU=;
        b=hBbBEZgzBI6VAJ6QJ6z801z8cKRKRp5BlHt0wxbfGYh1i/Ll3CxXYFDLVqysnVUP5z
         JyQpuqDe9+x4JfPxkaABK7vFZyungHo24DmlP8b5bSKTqr6ndNvU2hUQ9oLvJkTpvBud
         xe9IKcLwoA5yBapuHXNpuKTGt/NDBAreczuk6lzwroAj7IAFdmgDb7s3xYYC3SvJORRS
         4fdDrF3mbGDbSe8wfzvYYsxaaXoA/R+IYO3Xy++YCCqKBc1O7JQ/J4Nle31grjiymSeB
         AFPXF+5H5XeajHxGOb0ku04lPSb2qQie2s+ShQ8pcullZsHVZ5YP2x0ul9kaEC07xgCy
         L0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639863; x=1745244663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UF1+d4niNyOW8VA+r1HnFvlvMrBYZBQGW+6Ol6wzTU=;
        b=IRvP1J4IX+WVmW7iZtAB6gb5OdHMtsoB/kwW69Ndd1U8EfbX+/QowuxvVK6MvPOBPB
         njk5cjVg1eb3Bpmiz9EXwg5QoI6YovFfad4O1oUtheYvLQnbp+aV4q3WCq6QvEG4JnTc
         TcOINzO+7g4OQNc34kK7Nq1zmiuOib0A4iNvrxKgqdlqI8E8C0FZ5nj4uMl7OXXhygZX
         UEdaL5QbR8XXmt7JW0QFK7ykksPIX3HG7/c9ecrL1wKXp9LFXYcopqAaddU1cEFwE9X7
         codxZrKslJT1xr6wI0CbnFi2T9CA3MIk1zE0LJp1bKrX4Hb1zQXHPj90yElt3ZOk+5/C
         xDog==
X-Forwarded-Encrypted: i=1; AJvYcCVYaYylHIFMlOa1oorNbhHcM+TcGZFjrD2zKrTEwh/p2yuhKDBpzcW0nPMCjONf8+Gu30zeZexqFMANqmeIz8S+@vger.kernel.org, AJvYcCVnGs/s7NT/NBDmN5q0/LHH8rhx+ghYw2ZiVhPRZdPUWKUVmw1G5w5Avm8Ys3M1eAO6nXBbY9b6ZsizX8wj@vger.kernel.org, AJvYcCWz8+UJ+4Lc8y3ZC/PKML+lKOMh9JkXSO9lzdw1I72j6cHQIC1co2vbTMBHXqvGU61Zd3Pd6YjV@vger.kernel.org, AJvYcCX827BtMS4phjE+Xrm+BxwmiSXnAiVHnQfcW8rABY4lYLzgW1BxCRaVs4CooFIlGAGmFtQdlDlYfdyW@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPTSV5vK8dc4rN6zGoEK2FiQGo5ivQlEel852BMhd1as+26ed
	0X/D3iS2tfP3myfc8HW3L2jw4hhvWs+f0nExtY7iIYNgvErfuV0yaWe0pJKCYbpElBIiPqX40Au
	0rfdV6P2/aeGWgOLYMDfzmvosR+Y=
X-Gm-Gg: ASbGncuyfV11xZW2rPKbazH9qPAIQ8zuAKV54lnZ7s2nQ23wdzNYTqnyvi83ASBZ8hQ
	H7OXuV1bpnlrfTVaKIo/GVHPMb3Mlv2k9HxxFOG1G+gyoKaYqry8O66fDerczsfo9LEkVAIjSQo
	LjJ0A1A6yCEUDxIO0S1zgQTA==
X-Google-Smtp-Source: AGHT+IFoPgrticcftSCZx1LGPInW+lGPNUg8jlDa6rvGb7o/dXr02rm19k0XwSHPZJei1J02/SX8L17QergcAsaWUv8=
X-Received: by 2002:a17:907:728e:b0:ac7:391a:e158 with SMTP id
 a640c23a62f3a-acad36c3b7fmr979623666b.59.1744639862468; Mon, 14 Apr 2025
 07:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com> <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com> <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
 <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com> <b54e4da8-20a5-4464-a4b7-f4d8f70af989@redhat.com>
In-Reply-To: <b54e4da8-20a5-4464-a4b7-f4d8f70af989@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 17:10:25 +0300
X-Gm-Features: ATxdqUEK9qElNdnTKa2QHn3BaDCna6lMjxXsS9Z11fOG73o2nUUr80_22U4xjJ8
Message-ID: <CAHp75Ve2KwOEdd=6stm0VXPmuMG-ZRzp8o5PT_db_LYxStqEzg@mail.gmail.com>
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, netdev@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:07=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> On 14. 04. 25 1:52 odp., Ivan Vecera wrote:

...

> Long story short, I have to move virtual range outside real address
> range and apply this offset in the driver code.
>
> Is this correct?

Bingo!

And for the offsets, you form them as "page number * page offset +
offset inside the page".

--=20
With Best Regards,
Andy Shevchenko

