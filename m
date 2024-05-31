Return-Path: <netdev+bounces-99814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805F8D6935
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DB51F263BD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBA7E78B;
	Fri, 31 May 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gsZM7OMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C17E563
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181398; cv=none; b=uI13odvtwepE2KnFSSycu33AOZtjWi+ZlJAsWbH7qaUdSu6yuMtI2S+QmLbyK/cdoI+gibiGIUJggLAHblrRjeT8HoBs55FrJ7kTtawS72J9OSMGTIs1dcrCGpPqoksuQFLrcr16Ni+YDtSxn6OsY0sUBGrPVU10hViDW/4/5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181398; c=relaxed/simple;
	bh=+k2+ICccda+4JfnoM3HmzO3GJ/eyjrpDMyrYptT3BPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSVkX6c1uP0WREpQHnLBRO6LWoqRmPy1/pJ167P612TS4XtEJxMPK6I7c3GuxWNheyMJGD2X2Y7rOpRwVPMni9YMXBDlB1VwUYmPSqcjQ3d4PfeMYkPaSysKtAl8Ii02PlfOkONXYaY8se2k0uzZNFnplauTM+ao2zbfwsczb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gsZM7OMH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso1503852a12.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717181395; x=1717786195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itW9AwEPlcHDr0HplS3dAf2ENLgkkIePx+3YdEWFfiU=;
        b=gsZM7OMHVamDezpAJVj0Ago5LPa1Xqw1zIlsZq8lGZdxrhhdnAri5q1i7SoWQsmFkR
         swBiVpQEW6C5J0DS/4x3tenDX9BAPTXtwYLD2+fInxHxB5mP5ncvnCJjfaeHN3z37RYe
         AuaEJDo+yLIhgdX0yCbnTiO8qDECpAkd8D1do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181395; x=1717786195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itW9AwEPlcHDr0HplS3dAf2ENLgkkIePx+3YdEWFfiU=;
        b=aR4HI0v645dAkYut5tQwh3RvmsyQqj8io3r8RElfPxjiU5wInm2Y6xqPbf88k+MqNo
         Aoa1ouVbhVp6MPJdCOIiJn8Hrd7yzHgX3NcIvyV5EbSLCQUTbFq45DntzbE40qDwant2
         1yWc+PmqyRP6gcR8oSrdgXDSyWXyZjO4qFGWMwl1TyY956nPMCC5hYslHSHQKivRUl5s
         Ckb6rDCWiudSxzXVvmn4S6qvval8+7kBTXop21ErNYP8UurQ3D28L6n1wE+Y3kg0TW1c
         vSPz+xcPE5reiisQigh8oTA22g0DL8cUVcATHkGaNQNch7CJquJTRUzvGJvVWTGMPQPF
         47cA==
X-Forwarded-Encrypted: i=1; AJvYcCUgbc3yFMs31ppB5KbGOIKYOMpfoAe/+/VN6HfmkOxGyqkU+7//tGQsawiV+V4l5HEOi5S1VVtMNmhQaPBkDeq2Y46d05xo
X-Gm-Message-State: AOJu0Yz4YjP0C9iZrJyv2/4NVfIajDCGuhIH0dhEIddSdvSpdgsCMXcH
	jGo/51NBC5mKHG/Llnm06/B7u7TXZpX/us484kUFt5N4ot8S3yZhaDdvJ9r4WGzy6wzKGwVXw6b
	kBseqfA==
X-Google-Smtp-Source: AGHT+IE2N9K3zYFAYXCbiN/kTDuv1AkrtXhlaRgaVPX2aWLYYxkc59vcXZJKTzIa7Aj4tpCMzlgDTA==
X-Received: by 2002:a50:a459:0:b0:578:4a53:1029 with SMTP id 4fb4d7f45d1cf-57a363c0211mr1741626a12.4.1717181395134;
        Fri, 31 May 2024 11:49:55 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bbed6bsm1277655a12.40.2024.05.31.11.49.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 11:49:54 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a673a60f544so178852166b.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDl3NqJQXXA/tXTHWQILJYjic+4bvDUyQYzVHqAY+3wYwDsxpyG7akeL3yYHaMVR9rowwaC4cQqUcUu+PUBP2hoX7zixqZ
X-Received: by 2002:a17:906:378c:b0:a59:9db2:d988 with SMTP id
 a640c23a62f3a-a6821d647bdmr200744566b.50.1717181394333; Fri, 31 May 2024
 11:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530132944.37714-1-pabeni@redhat.com> <171718117960.32259.11784216389309914917.pr-tracker-bot@kernel.org>
In-Reply-To: <171718117960.32259.11784216389309914917.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 May 2024 11:49:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh13CTo4vhVUMPSxEZsxJa8JW68Dv8=-Sd6V9Sg4fA42g@mail.gmail.com>
Message-ID: <CAHk-=wh13CTo4vhVUMPSxEZsxJa8JW68Dv8=-Sd6V9Sg4fA42g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10-rc2
To: pr-tracker-bot@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 11:46, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Thu, 30 May 2024 15:29:44 +0200:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc2
>
> has been merged into torvalds/linux.git:

Technically it was merged 24+ hours ago, but I spent yesterday looking
at the arm64 user access functions and for some reason had just
forgotten to push out.

Oops.

           Linus

