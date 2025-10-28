Return-Path: <netdev+bounces-233524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55BC14E16
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41344505639
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622C335BA7;
	Tue, 28 Oct 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCXV96a8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4621A95D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658376; cv=none; b=beKlqmfPsvy3sDjl1z3xWCBbPC76waWPFYduDjGp6btm3ecUyQb5jUHIPdD7uoqHiOpVvrqDcq1+qgQBX9GgBq5MAl1uV0LKa4aelaW1jalwvo8top1yOmydCNXdqSYLaDBpODN5D1DoYa6/qRKK/Yz3wVAXocTiwe2xsKgaCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658376; c=relaxed/simple;
	bh=aRDT85f2vXpnIMrSCKly3BHwISabax0t5yj2oRXV6jI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PPOBiWjl4O8Q9CINl7X4JFXbgHjB6lxka6DJFZOn0ghLwhgGFiOxxjlu/xYfHrmkTrk4X/RG7ht/CR+q2sDnoYDXZC0FY+fi5uAp81nIFKscoqAs5tNtj4fOOHhQGbhKO655kewqE8KbQ/2+PF3R1zW2zX4LOyAMXvx7Ws549z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCXV96a8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso4470596f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761658373; x=1762263173; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRDT85f2vXpnIMrSCKly3BHwISabax0t5yj2oRXV6jI=;
        b=cCXV96a834+U4f/ChsidaJTp88Y3UftHQjU9iIBpcMG0d5BEbUmjYKmE/quWjGwRmr
         AgD4BALgfl7TAUWUwBv59ZEjnlWxz1SKEb1wmAtXeE9WHWhsdW3uMSkUZhLrCcUNdNl5
         Cvqpf15pe/S1wbp7IlqSw1DIzFkDaxFDRaB7TuHNJsekgKk1728xAdK6kaIYfv4zeqLk
         Tk+phT3aquIShJWgWLZQ/WGxkChrP3mnH5haW1DKnDmhASpIac3e6izfZAd47qCLgE+c
         vCsMPU50VMVjbfs0iCUVF1ZeahllxRitIt6s2thICaKSnaWXUN5ztX1f3q1596MpPzWH
         TA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658373; x=1762263173;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRDT85f2vXpnIMrSCKly3BHwISabax0t5yj2oRXV6jI=;
        b=kh/iyqUjw2dl69M9EtYh5CEdeLv8tPyt/DxNgk9+37sc315TCy0iIvu2IO/0fYMRrt
         qqZ5Tw+zy8MlbRSF4v4leXZ77WyWSTbtGAEHC3+1tSqkwAxT3koNxCHTMUyhSCmZFlSy
         w3sKpOSK6l51N8Gd8NYNM7WtB0B7FgsTK/5AcwibOknw1Ip7ZGLFdA92EkS4c7Ez/Ulq
         79LdEp2aI0B47s6oesy9CtRae6Es1QJ2LsB5abAtIXWlzXRaqJ2ER+h30aCWd2XiYncw
         n75GTICwEysp2AcK6pCzhsr7FY5GtkkbTcxcCaUgCW31+06UYRudVc0L/MMM8BmP4nYB
         4z4g==
X-Forwarded-Encrypted: i=1; AJvYcCUw7z9RykZFOTRj21Ug3ikSmAh9JvQXuRIvL1sMCvEDwYh8asA52YYHzdiWRfHJtbgnffSjrMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnA3SBHUm4hBnyfsGGAYN+97synV3Q4NCL9bRdtDFq/0nf3O+0
	TBVGoy523l+k3nIZUNwLW3fHTzAoG4xqjBkplWI9KpL9F/I5QbBJU0YX
X-Gm-Gg: ASbGncsmtf6bDjw81BtKLbJtEujFJ6xyR0690w+3dTxgsFsLYnnX8N97dPleGW3HlMr
	GRqggjGHAGVPG3ey8L+/4z3yn6lF3RC/bL5wtn4LNV6n96MWGbxSNWu12H5UitjVY10InNJY3Mq
	O2LW9EcOFGZvlSjHW1Xj0gomy/ekYxAF+/pHe+gLqzLVl7OdZpd6uCCceFDRKbMN272ls9fjsb7
	+HOm1cACB2urHy33DWW9WMZbp+qegcGji8RCJ4rRGayXIS1CHbhrfazL+L6RloF5GTfgB4yqy+6
	ii2DpynHaT9ggAl9Pp74oWWxyEYgBi0qrOBfjR3pxv4tD8sXzTdX6G04FeGt+b6Xwjf4r20rYyu
	ZLSc56iKqEQx9058P4535QzrOkoiv5nbdfuSq3ou8JIV2Wp/zFI/YZuLcDc7JG5AjSLMyXU0BQv
	pmki4hDLzXvmy4BhqPZxqHjRs=
X-Google-Smtp-Source: AGHT+IHK8UV0ayblLNGZRsvS3+1r7VGAI1Q6GE/eWCWEeOx7KEL8AVWIGobEhWzr0uViNQ0uiG8GDA==
X-Received: by 2002:a05:6000:1862:b0:428:3c66:a027 with SMTP id ffacd0b85a97d-429a7e82e51mr3326800f8f.54.1761658373223;
        Tue, 28 Oct 2025 06:32:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a938:2bbc:5022:a559])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm20451746f8f.41.2025.10.28.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:32:52 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  ast@fiberby.net
Subject: Re: [PATCH net-next v2 1/2] tools: ynl: fix indent issues in the
 main Python lib
In-Reply-To: <20251027192958.2058340-1-kuba@kernel.org>
Date: Tue, 28 Oct 2025 10:50:23 +0000
Message-ID: <m25xbzqp00.fsf@gmail.com>
References: <20251027192958.2058340-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Class NlError() and operation_do_attributes() are indented by 2 spaces
> rather than 4 spaces used by the rest of the file.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

