Return-Path: <netdev+bounces-170821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE61A4A0FE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622E1164377
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A31BD9F2;
	Fri, 28 Feb 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LM6j57Wh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916E1BD9CB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765323; cv=none; b=kjUlUScsRgGBxpESQocviXuRyexk9ZjJz4B0GKElekA/u0SweHKXPeWDLzgkCD3j1UqVngs+2wgfidMCl1eAPFy72qX+O4dFOH6f4Kaos9tk6POcixN4MrxwQt7ZTxSf/hRPmf4ttJtCh0WpRaA9KNo02YEKy132wjzeSkRpZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765323; c=relaxed/simple;
	bh=BDtIVOH1NfH7H9DNGCl9q3I0lK9HndnLOPEmc4jcEnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQx4THPfwAYeh8XmlyuXoDK0/oaOIluQmhcwSogQuLBUv3azDl9cswgDgSWx89yOdXvpJFg7xlqllPMcIp4EvjdlPK+V88MQMapsB+1JhC9DS+9VPw6q7Eh7htN1ZGRYUpx9ElqOKIMkTHqCdTFSt6ZE92/P7uWR5EJ8Dxk6if4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LM6j57Wh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2212222d4cdso5215ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765322; x=1741370122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDtIVOH1NfH7H9DNGCl9q3I0lK9HndnLOPEmc4jcEnA=;
        b=LM6j57WhlRsJEsI3FSS3S65ow/oikVW7XXFx+Jt5fcC0q+uRZhNfbQSQMPweDVq8OY
         w+lLMME3L9QOAH8bCyaLplDOEVyxLuenJswibjgKJySh8IiZzY6wPMw5ElB/YjgosNH+
         qEJGw5oWTjXUyV8N7bIkLsYQgS6iq/tFplTrGOBtUSi5VMHXW2eiOu+4tBK8MN7iXRzt
         xUKS/oN2xZxHSUzkx9XGS538aYiiD++XC/0Y9IURLGr/cXTqNSJNEEwBIy5M7iyVe5H+
         dCoseAqb2+iVhGb0+RAXY09HxTMaEaRuSDN1Qs+8fG+cBhssaH6dbmoPgZuTV+k8GzBp
         KJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765322; x=1741370122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDtIVOH1NfH7H9DNGCl9q3I0lK9HndnLOPEmc4jcEnA=;
        b=sa9rZ4kHYnL3Rm4NSotwoWiv7OF/UWkdHP8mSYlFlceL1oW826Svy8HouNiv7g+K5k
         ytvbId8ptE16hkDYoyE7N//vXTWlA0FtwJ4pR1Bfz6vUpE6lRT80YKIvAz3nLYijboIx
         /Q+fwHXAi+8Hy1cJWH5vDcJUCwE3M/oXksv1a7CYvIjvQthWV32odymvq2mTFb/MAIx0
         NR+FC8xOQ2k3lVwp5p6vB7+QeaSLaZWrZIUA47uv2LAXlkWDj8f0GAl4XUQQc0Xh3sRt
         MbXdCtl1YECgSdeEbLz8kIA8giFqnd/VTpSJi0biIRXQ5NSHA0JxmV24d21KmpPl3M9u
         XLsw==
X-Forwarded-Encrypted: i=1; AJvYcCVwYaEgIkWqb/c0Yswv4PKc7ltWR9gLPTMwK1uVt6nIV9KxM0gT/YjhedGvPX7Cp0S2eT+Ugno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvIQM+ZavyQCJA6GuzQGqP5SmhIC7ETSBV7ZeRhCVm21NLcRz
	q/loSRSwJEa7mfGtxTilDVpRUuh4C3gjZfXdDruuonxeN7JpuzpleSMgCMrSV9OGurE6fvcaZ34
	XxAf5tXzNS3YeHtyOxHFNa/B4KkMl3Gi5c1Dw
X-Gm-Gg: ASbGncswsGdHWinCTK/Wr8rkARgiLpcLdqOWri+ejPCDd/126Zb/HvM3Ga7X2hkUd5Y
	56Ag8OTt3l44BggoLpt24KLqW7oGFQ+pflqU5FbXtu8VMq2Cwdx5QZ0P5esDGcIrYGjfd/ZqLTg
	q39uRTt/DATG8T5annYtyHdq+qtWWPp14ZrJmL5g==
X-Google-Smtp-Source: AGHT+IHVrC0pf9G9pIx2c46zefAYiMfkRUSi7NauTktyEJjZAXF+yeXwRiO6V0ljRkibON+xuJpNZQI1ZGCBBAVHyRA=
X-Received: by 2002:a17:903:2585:b0:220:c905:689f with SMTP id
 d9443c01a7336-2236cfce369mr2628425ad.25.1740765321373; Fri, 28 Feb 2025
 09:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com> <20250227131314.2317200-7-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-7-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:55:08 -0800
X-Gm-Features: AQ5f1JpQ9GjXK9nTa6t7O6sgvQFQLlYjz5k2ufAERyY9SiAfVcW512dCoRInuyc
Message-ID: <CAHS8izONszMaV1Sq7RMYApzo+nFNK377dq_9Up_o9UVJAUf=yg@mail.gmail.com>
Subject: Re: [PATCH v8 iwl-next 06/10] idpf: add PTP clock configuration
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:18=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> PTP clock configuration operations - set time, adjust time and adjust
> frequency are required to control the clock and maintain synchronization
> process.
>
> Extend get PTP capabilities function to request for the clock adjustments
> and add functions to enable these actions using dedicated virtchnl
> messages.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

