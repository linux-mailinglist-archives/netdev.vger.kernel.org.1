Return-Path: <netdev+bounces-140259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3F9B5B07
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43234284285
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3582899;
	Wed, 30 Oct 2024 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBQhpRqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7466BA4A
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264686; cv=none; b=pB2A2FdIq1NDUI2Gv7wO505TQiPEbZNnsA3AXfh54DAQTy93u4bX7KtslIa7LbKGBzxSdA6txkLdv4FW+VpPCqpYsoOci086QKfZShTFr54l0iabK01/tYKz2ukSdz/8aJY0xKdhpj6G+UiSXMG9fNB+3/bda80Bs5NrXoRf9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264686; c=relaxed/simple;
	bh=kENvROmXFOVMy3MzRezX/8fz+65kXsPNPzgmMIAes6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTg1KfFS9ALn1RzWsF55zH1rPYx4eiRmhC/IqU5nxhaDmG2yis2Nru0sIOKRn6EPPzbjIBrObPDqEvoZoenyu1HB2kyZTs9T5M8LR8K/moqawA0mmwPL37ui9Q8AM37v7DtCXTihG4Oh1fL+wrx3To+9aUtKFEgVBUoKMlGyGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBQhpRqS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea9739647bso4457864a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 22:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730264684; x=1730869484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kENvROmXFOVMy3MzRezX/8fz+65kXsPNPzgmMIAes6A=;
        b=YBQhpRqSlANll25zBwa4IKjvAw0DfM3mLKX6mZn+b8xCRTkzkMyX36uFLBZVsLKDq5
         AZPIsvPTEv8qRha4QK33AC2BDOtzFyMcHAO69cnIJZ8U1a3ObYHfiDOA3i65ZPDzNb1n
         /F31A3xaSpJ60aB0h14Qc1q/YcuSjcAjwEaVC23gRccjMXKorh7kPNdNF5Ke1HpM4OTZ
         HNqhqnleYR5rhiH05+eYyP3dZHjX2uHPV2O5WtKnLsGiRl/USXvmr04Njij8MTh2Rokw
         FuJwkHlcy9+wfDMJ7FKDH9XHgxQU55auuiSfcTL0CARRTb4W5ixUlzBTTQFyCx+/9e5L
         zhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730264684; x=1730869484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kENvROmXFOVMy3MzRezX/8fz+65kXsPNPzgmMIAes6A=;
        b=pN0jAGQGR0u060cHJSdxgUiNCLWS//eN9glPEQpzE18cKAcA34Q3dwAs93jA4OH4JS
         38g5OBDTWEnBeTQIh298bv1PQ0zq1CqUJZFitpNJ2RKh48TSaTtRs3n33fcqcTeKWrlr
         8zpqfXKirXJ+RmhdY8N9AB5Bb8Y64C/0yTIvSXbIZ5+ZKu9s5DjXuAlVQNcPaaz9JIuy
         cE/zBkRLGhF7UynTVkyYtSCoQC2bG6eZFw26y0HX5uXzxUjn2wOcrdP+29V2siuy1dSz
         ZltPUnVLnanHvEDg44KV4+tRXtjcI10fv4ehAX1U+W06V1Acq8PX5BAqlF6GhZ9cd1AF
         U4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxJDBb4CIWKC0lh/Bbfh2xC78vo+/4ggYFbRYrfhLYrwlgKu6l/F4tvCGh2mWzmTk4FAyg+q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+Hd7inbnf8AOs38q80/wwa6h1n3gVIqRtNpHzSfWkEVQbW2W
	vlobg7oAEqkOCe86wCrHcPVhIfWooij5YQ0UyyRfm7JQwaJTcoHMxq0D6980wwyU+DuNZMNkKWp
	8IUBdE7X7vjnYvbbWtVaRY+p2aP9Xqg==
X-Google-Smtp-Source: AGHT+IF8wNkNXVikoxU3uYTBGNhzGSKbY9D2acpsFQytYhILfTi9dPoWkaPPjl1zpwXjkxWo9FmcXYh8L0DK8SlMCQU=
X-Received: by 2002:a05:6a21:e88:b0:1d8:f171:dccd with SMTP id
 adf61e73a8af0-1d9a851e08dmr16053235637.37.1730264684147; Tue, 29 Oct 2024
 22:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>
 <630f1b99-fcf6-4097-888c-3e982c9ab8d0@lunn.ch> <CAEFUPH20oR-dmaAxvpbYw7ehYDRGoA1kiv5Z+Bkiz7H+0XvZeA@mail.gmail.com>
 <20241029153614.2cdt2kyhn7sb6aqi@skbuf>
In-Reply-To: <20241029153614.2cdt2kyhn7sb6aqi@skbuf>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Tue, 29 Oct 2024 22:04:32 -0700
Message-ID: <CAEFUPH3gUV3WXY+VEr-9H8Xu3Zva2jiT_WY+Edp=Q9Ja33XwRQ@mail.gmail.com>
Subject: Re: query on VLAN with linux DSA ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Vladimir.

Regards
Simon

On Tue, Oct 29, 2024 at 8:36=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Oct 24, 2024 at 08:15:50AM -0700, SIMON BABY wrote:
> > Any advantages of using vlan aware bridges?
>
> Bridges can have more than one lower interface, unlike VLAN (8021q) inter=
faces.
> The lower interfaces of a bridge will forward packets between each other
> according to the destination MAC address (optionally + VLAN ID), which is
> something VLANs don't do.
>
> I don't believe that a bridge with a single lower interface (port), as in
> your example, is exactly "intended use".

