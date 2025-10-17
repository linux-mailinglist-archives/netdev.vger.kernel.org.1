Return-Path: <netdev+bounces-230527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDBEBEA3E3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FCC740BD8
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15009336EEE;
	Fri, 17 Oct 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEaJ7/ZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62872336EE7
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715224; cv=none; b=qMs0mrn8pHE+tQcpFDDZYx2IT4ttSCcWtuBUKF/Fs6u94xekmzKMyyjaXDrsxqwlffBL+LsIeNtBwrU9aTA1JQY29Xu5c9PV7rOD5iAvyhULM+ZnfsI+EYD1QCbNdloX7EphlnA7y8FDgTJQUWjBqwMyCxvp1oVQ3svjVlZjF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715224; c=relaxed/simple;
	bh=AYDyBoqSGxp3sLQaIrRnQxkp9h8SmM+W9ExXpNQDIpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXweFqksuqIGWtm2o3qJYqN7kSd2MAEo5K3bDE8Z/twN5Ow1PG7eXduwxaEhONDIEV1AtBDoP5OiM3LN2U8FGhuc5HaDQgaUBv2QsFYwgLfB/ftLbAMOhKNQAqiKw18tWDw+/gXjxveGiIqyDzvrkK3gWX8TOeqXoWbZphGCiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEaJ7/ZM; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7826060df96so17282407b3.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760715221; x=1761320021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYDyBoqSGxp3sLQaIrRnQxkp9h8SmM+W9ExXpNQDIpQ=;
        b=eEaJ7/ZM/13IWVXw5oeqXMk1MU7bmREGEhXoPRf3bWnphypliFm33zeJvZfiqMA1OL
         OFnKpKMyQEEkte88DkzZY894ZdIsgdPmfXILgGRijbpGLIAwxYk3RTOXlYHL8fxWG/e4
         deM+QGs4XY3zHqQFPSZsjZwEN8HFAE8JpZgxl58TU7tNfaoEa6zYthERlDv2LStD+go+
         NegOKgLZiHVI9U0QlvIUFqF1MYEFNbPcx1/kc3nIpd8ksce9jyMT57xTkbANFtkSZSiP
         u6Qn/JaUcv6sDEy9BNoGV0MP3oFPrQhvmEdhC8hfl2GBi/qp30LD5YdmrxY8RAK+Sboa
         /Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760715221; x=1761320021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYDyBoqSGxp3sLQaIrRnQxkp9h8SmM+W9ExXpNQDIpQ=;
        b=dSPVMWBTei2aKPdpOS6ldTpOtK2vfuflNwwb9edE9d8AR5JPKgTEIp12lqEBnGh7jC
         CEfy0of6m/psntdprwpvPh5EYuomuxQyU7f9nXbtCsJhP6oPpgD3rdWZJWBhXlc2E3O5
         NqRLYvA6oEArNxM35tk7sFEUAtetHzj73/CJZY+sGoDhyAIaogbvyK6P70WOtZYwqP90
         /++nnB7p/pNQI/Gxp+/i9tuoGp46jrBt2hFWMPfK/ADsw2DlbZ40TfqHco6S1g8v9/IE
         blK9zQfvY41NVPb/9gbvH9o1/qaJGrs5UDr5smHD+WzojXqo7Xu74SPGWtVz+y9iL0yp
         ojaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdFWlLCU8/ST1t1bKK2pAeaORYQ1eJcbyCJzRHyIKEeNHtKUQ+UDW8n0/oySQbQKyXkE7ywtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxa40gRlJDGic0HG29phIklTUPgyu7+vHH6S2b8MrDGrn9r/1
	tNcnJjUnOjaavZ/yNd4DJafmgYA4jGga0sEIle+DjRFl6Y64GucKv0X/lk6efpSmxHg976VsA+1
	CBNtmUFUcBgsPeST4n176oaO7bOhzzks=
X-Gm-Gg: ASbGncvzFH5TC0RSr1wiNNCVlZA+z2x8yhF1dhGAo9pcw+4h6xwemW+ik/eVR33F2Vm
	Y+Tfo29k+XRdsvGgXZ2MBy5eEoSCAB8+LoJtdNyG1u16sFDbEGYDp0dc9uvv8EyKnIzcI7NuKCF
	P7jRikVejjEXZSQyL2n/E/gNUuoCLyD6IEOEBN0WY7Xx/NE/G4jfKHKXq/Zv6Rd5rsv2XcVK9TL
	bvZlt/xxKR8ahrMtAvJSRkhm0LcgwKUrqLW65pruhG6J7dHNWguGX7O5lk=
X-Google-Smtp-Source: AGHT+IEO4gGGrFgVxNj0joSKzwqK7reU4snr2LDuZWleqTcw0PJZE1dEBv7ao9Zj2BRol9e9zJSHmaElOFROlCzKKb4=
X-Received: by 2002:a05:690e:408e:b0:63e:17d8:d97f with SMTP id
 956f58d0204a3-63e17d8dbbamr2676488d50.34.1760715221313; Fri, 17 Oct 2025
 08:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017100106.3180482-1-michael.opdenacker@rootcommit.com> <20251017100106.3180482-3-michael.opdenacker@rootcommit.com>
In-Reply-To: <20251017100106.3180482-3-michael.opdenacker@rootcommit.com>
From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date: Fri, 17 Oct 2025 17:33:29 +0200
X-Gm-Features: AS18NWBsu3k9OEM7-rP5g6-76bcKbcZ1KDEc8v6XA3KbUIJDEMiQsuWyEbUxtbo
Message-ID: <CANBLGcykz77U_V4CqE7PHvtgmeXiKFo0FXy-sHHiAoZ11HnCjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: spacemit: compile k1_emac driver as built-in by default
To: michael.opdenacker@rootcommit.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 12:03, <michael.opdenacker@rootcommit.com> wrote:
>
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>
> Supports booting boards on NFS filesystems, without going
> through an initramfs.

Please don't do this. If we build in every ethernet driver that might
be used to boot from NFS we'll end up with almost every driver
built-in and huge kernels. If you need this there is nothing
preventing you from building the driver in, but please don't bloat
defconfig kernels for everyone else.

/Emil

