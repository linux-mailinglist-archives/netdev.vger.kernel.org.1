Return-Path: <netdev+bounces-237069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A03C44558
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5312C4E06D1
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307A22FF22;
	Sun,  9 Nov 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UMdgKNVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C501E0083
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762714779; cv=none; b=ecn2mT24Z1fnMxKqkvpNs9BrOAvTz9prV3YJeRO0UnUQhism9OkyP+jtVN7ZG5sayYM65NtRdgOD9VEys2J8AGfTV0tDltcEFhsd9BB1bpxnSIWc5P0sxI1lmUO9IVQNfGyASzvmCZDbBKIzlPbZ8XXGFITjW/Y4OXRDmGnD8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762714779; c=relaxed/simple;
	bh=HD4t1cGhuPrjl6kQH7Umxu+RdFGov8bvi1LsQMZBnEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTTWZc++ON3Egex1yXZW4DX3RPMU2cxVcWr83fXj1f/6oIgyMqY4Oeh6w0xhBYl4goITNHSukf4hMTz5silaodU16ycpj9gKo4S5+MwHLm+thpnxqxNjAd8vU+6F+DOWLOaFbjUlzwWUx+XyJBamIOuRporPWHuMQma8wZgWOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UMdgKNVj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7af603c06easo2039616b3a.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762714777; x=1763319577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMJe7s/hUls9TG7fMNryxhH5bJapaWZJnfv/mvDzBhY=;
        b=UMdgKNVj9g3QPFciXDIV71DlHc5LJRIf4NX4utlYufwaq18aLe7BDtIFUX7Q2UmXZL
         jennwLVAiqIThNQS4j/Jfhh9njWoPAAI3hwRuwnuLIZtiTNmCBJWvpJXj9aojHaoK4Lp
         NGf120X1Pol72m/gLslY2mgpK6UvGXlezCSaKl8Y+T4n3/lS4MDrGfKucPynVoF75CY7
         1drulWbGkbJJPYWaNV7N7jDwhel2rjPYhon6MNmQQN+h38AoNWfi5M+FfpopY8tnSHH7
         mA5DQixTsVQT9zYxjPm/94dEFJSg/Qt1L10wJxhZejpr+WAETsR6sFp4p9GwYxfrvYAy
         S2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762714777; x=1763319577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMJe7s/hUls9TG7fMNryxhH5bJapaWZJnfv/mvDzBhY=;
        b=GGTHmLh2qYBG/pY8mqp7RVnTGV+tqgcNTIRDjbHuJMuulyhAyJfvI7v3IG8/2LgDf1
         0RC/tkuVAF0lzakQ7NV3db7mMvvpv2z2jlxCd3WSsmEoQobwhatNtBWBVjtGsWF27f6I
         2K3I/crIHm7lgfH2ppKiq4POXofJdAmrRG8RTLe6bhx6NBx2yM15QXh0cV66WriLrS6B
         RveG0CpcXX5hVg6RdNfwkTpuU2WXXcFvixTl0Wbv+Gs/t4RkVCUDKVSB0ZI/euV5idQ4
         HKILEoIPLuIqfaocbs1xcGTgevlcQ9hzgE0m5C6KciwVehgpPp90y7W1zKylM8zbPfUs
         7Kpg==
X-Gm-Message-State: AOJu0YwPR2JS/rCn6Hhpph8XgUgoFzZjgGOOJjX3BiJ4eawwwJSA2+8n
	IHYe/OTdFxCAjnpvgCyexuch0UwfOCFF7Vv6RoC5vtzNAEHAnXcSRMYBoAql05ttN7I=
X-Gm-Gg: ASbGncsMBaskCxv994yKymtkPa9TpvN1dOeahye6WUTMjlIsCAGTkp7RaK0Z7N/kaoi
	jYD6Lxw1EA2Hlw3YSXp0qunLKKOQSfb+SwZY6IaxZibe4L7p8cHNiCfcShjrNBtnDq21hNzBUKe
	F3g4DNYTkpJXYLbO6SIOWmOMP/BLbG5g795pB7rEQ2ugmZ3EuQ5e8afjY2UCisF24kPmnOAJIsW
	rFRaolZndmIXwoTWvL80QaJNodyfvWySbixFf12gv54BxE+Cowq2dFNOHt/3k1C2qGVxs0bZHub
	N9kEOxnE0R/c35mjMJuEP9LgDCPruH9Fm7L9hLTnFtxZ6Ksk70+9+aw2NQvUL4q64OhARi+FCz4
	M+zzFpZfZJo2VfOhNpXSECI6ZqI0AzmmFHEKS/ur1PyJfOs/T+s4ey1aZJaiKQDXqZM4hN9Uyh3
	uTU7AeuGmTMZ9qKYy8ZygO1TCIeKnMS0LMNvDARlZjAIEg
X-Google-Smtp-Source: AGHT+IHe2YgQM6f6LkmspkbozbAun8C/bbx1mf9ElvPTPy0U8FIaeWyPBCFS2zOn/i4evVfD9AK9vA==
X-Received: by 2002:a05:6a20:5483:b0:334:7e78:7030 with SMTP id adf61e73a8af0-352b62f7570mr10148302637.8.1762714777406;
        Sun, 09 Nov 2025 10:59:37 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8e750c1sm10425870a12.1.2025.11.09.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 10:59:37 -0800 (PST)
Date: Sun, 9 Nov 2025 10:59:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, jiri@resnulli.us, Ivan
 Vecera <ivecera@redhat.com>
Subject: Re: [PATCH iproute2-next v2] dpll: Add dpll command
Message-ID: <20251109105934.3116270d@phoenix>
In-Reply-To: <20251107173116.96622-1-poros@redhat.com>
References: <20251107173116.96622-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 18:31:16 +0100
Petr Oros <poros@redhat.com> wrote:

> +struct dpll {
> +	struct mnlu_gen_socket nlg;
> +	int argc;
> +	char **argv;
> +	bool json_output;
> +};
> +

In most other iproute2 code json output is simple global json flag.

Why is argc/argv needed after initial parsing?

