Return-Path: <netdev+bounces-117638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F194EA75
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1195C280E88
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12F16EB4C;
	Mon, 12 Aug 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9AxKi59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02071876
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457129; cv=none; b=ClceoCQhBMQvRCAiurp50GMwA+d/VGObRtWm3hAs/E6bn8z1/b6NYonNXzHkwKz7T0yuTJvUdUeHQjYWlyE7/rz+dkc7mW5tzTu2Qh12GCWvOVdmu+Km3AJs51zG4mGW3DtOmUtRaeAp12KU/FedsFEMkSBO2dwJkVMBFBNy0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457129; c=relaxed/simple;
	bh=aLH48QAGKkRNVSjvVFikAZWi2Uf+vcqUnSii01C4MdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnTpXXN+HuVhOCPS5Eg8uqfzbtIia47syx8OkQT9ImJnVvI8kGT4O0zBGVldHXD4KrJqhd8UGRLXxdqeun4PI/e9HfFUb3i9KHewwIFO3tWQ9Z1/bnubE1kUDThAz88lI4+DVaCXXKuO0assXxSZJ82oRP+/mE0qFCLk2po2cOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9AxKi59; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70944d76a04so2337299a34.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723457127; x=1724061927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aLH48QAGKkRNVSjvVFikAZWi2Uf+vcqUnSii01C4MdM=;
        b=O9AxKi59JarGkNr5gCORs8qpGImoIuocFjkuwLAYHL+5/6EOWBHsg0QVp967J9IKU7
         92ZJkdBYgqOSk6ns9ARvOBU/D4Rc1zAgLprAEoy75Nnsk3GqlPg6YVwuebPqZ1zlGKGk
         WYLVhlgcpVIWYegVWVrz4WOmA1gwUq/IKAqHsdQBrFEOJu7qd8miye2Hj/oK0L/QLF2/
         xALqA2jeYi91HMChBbd2ECnNGw/9lQd3+7OiaL3WJ/zOsrJVWkkpOzOd7RkdlB77mRRm
         Wh9ii/LPjs9HoEQvw0xgG3dcOgbHGzYrfJdb17nTjSYe/BO527YN0fM8jKoS8GmO2SLF
         1QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457127; x=1724061927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLH48QAGKkRNVSjvVFikAZWi2Uf+vcqUnSii01C4MdM=;
        b=NZ1S/kskmbz/VmLawXvRbYmZLySt3rdu58Fenf29AsBf25dh6zdyoRzSrhyOdI0kfE
         sWPBnNDQcyRv2OfL43eOQ/GhrwWgpnX+VqGlf1XmFGnRC3VB1Vh3iG++ae0Fo9PuC4dE
         JC2pOy7E4EylL1Ws1u/af78TYTzY7u18QRcEwW3qa3aqW6TeKoDoZ1LPZpVmkk/h2jNr
         FFfPF+F/nPFye7utzMEMUEm9qr6mORUs+0zIu7GAtV6lqmP+G4d56vrQ8L9n46nguYWV
         z+s0Ptrkihv+yfKOKyk/hURMD9r2KarE70K5xrIuSttreWoGGjQAKpgCBgwZX8mpOPby
         Fylg==
X-Forwarded-Encrypted: i=1; AJvYcCWKgygrrcbRdtUAAypSVH7Jhfm2brEQmj+JCHLXjghrRHp9SDMtvn2sldQAIDwdnuGkeJSNeexFRebx8EZfphjJZCPb0V6H
X-Gm-Message-State: AOJu0YxgMEb+G1MJ+n2r23HIfcH0K7h+Cul2jpKkIAh4Rm6K9B+QAk6Y
	951XS4Q1+L4XSQlDEId/W5PzC6J2ePezIc5DxDa69ruwhEeZgOoR1EMDJwECuXrnyz59lOnuzhY
	MVQhsUdj51QqYrFDY3I3yi1cB8hg=
X-Google-Smtp-Source: AGHT+IEJ+tlT7wY42PAyUe07nCIJf7MocyulnaOPZVTAciZuLCsyt8cBQsbUrMzZtwRcbN5c/NBUMMoozO2Xb7fdIBI=
X-Received: by 2002:a05:6830:6012:b0:703:629c:5e03 with SMTP id
 46e09a7af769-70b50b97514mr6112977a34.13.1723457126789; Mon, 12 Aug 2024
 03:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810053728.2757709-1-kuba@kernel.org> <20240810053728.2757709-12-kuba@kernel.org>
In-Reply-To: <20240810053728.2757709-12-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 12 Aug 2024 11:05:14 +0100
Message-ID: <CAD4GDZzQ4Mj0_=u6butyOx26b66pHE5P-JigcPEP7E2CKEu1YA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 11/12] netlink: specs: decode indirection
 table as u32 array
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com, 
	andrew@lunn.ch, willemb@google.com, pavan.chebbi@broadcom.com, 
	petrm@nvidia.com, gal@nvidia.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Aug 2024 at 06:41, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Indirection table is dumped as a raw u32 array, decode it.
> It's tempting to decode hash key, too, but it is an actual
> bitstream, so leave it be for now.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

