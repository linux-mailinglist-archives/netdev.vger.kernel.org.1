Return-Path: <netdev+bounces-154772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD099FFBFF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15661882CCF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB312EBE7;
	Thu,  2 Jan 2025 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll01mUnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6372D528;
	Thu,  2 Jan 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835930; cv=none; b=DLZ5W+LibwaA0AzjtFJjtF7EAu1P5DNfmUOLnIB2Awn1LYai+yAbgAPf07W6Q3AC917T/XH5Yz+2f4M6oRC6/PX56XI5vYmVkleIHnu98WUWlwIJBjr2LdKgEktaZEWJceD6nGrf+QUHu1XjZGjWCRaFaHKzJa066Ee0GOO+DbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835930; c=relaxed/simple;
	bh=rr6WOJGzo4g0fvb5ofoxbIvLntk66OjqZ/Ol6q4A8Uc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YtLlBuGRrzuutuLraxIWXgVNrKalZOteqp/8WURClxKngGFp5u6cz+zhS30EAOJApJ0MA6fpAzB6EofuzFLfaUP6s3WTaMalETkf8TdMnegJV5Oo2EPHZFOn+lpTf+bGpeD36gr6xeJNk5qTAqsk6AFQyj2Xb7cut0CDbPDdP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll01mUnB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436ae3e14b4so20033035e9.1;
        Thu, 02 Jan 2025 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735835925; x=1736440725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEvPCQRzblKdohwXM/4Bz2YjXIjzlQUfS94+Ar1OdsU=;
        b=ll01mUnBItHCs57nLn6iFTX+L+lpKPh3jiY3HP7u4K3Ge4H3iyH1hmxUuPSVnaQhX1
         hFfEHZbzaq9R4Jrm22V4ypunHTvgnFao7oCyJX6PT0CUnJbtkEOmS7F8jTIh8jFaI28a
         IXTkOjNOBFFlABZzhCM0eepdSAWAz5plz77M+MucxRpPjlzytpJrs2iXsN5TmXWMdgia
         8EYO12Ss8Ol03QkuQNWfBvMHHpmnVinGCBujdlUAGzQ8tVQtbP6TT6C7bCem+cHgFyNy
         KfQwxBeRiZkeC49wCumpITQ2vHhIYebQpFVRqzuBMeLapG9nmxE7BBe6jn8pPXA71O87
         p0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735835925; x=1736440725;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEvPCQRzblKdohwXM/4Bz2YjXIjzlQUfS94+Ar1OdsU=;
        b=f0HMWX90DY4yxFGhmLYmwZyMnEmkJS1hTUazUO7qmczA/KSr44ViVqe9u4+uockVcH
         IxOuyo9On0DnXec3bBL/b54vlV6pIzqQ+i8S71Lt9RqvYajBezNJndNUICGLCFWGpy32
         B3cmnhHj9FqwaSZetVBZDB0pBElXLwXtXrj4ctrlpXVctoBvDuUSFgJnVb/nPeM3Z6Tm
         m2GC2Xk+Vcd29fd1YyP4kCbA44pp4PpgFJUvRTGfSugMKLPGlmplsjLBfTilYQjcn8cZ
         wagAvug6bp/2R0C9UwpPgCoAbRjQZwqNO8PgZkpwwGbVOJ14N+ZspI0EQVH2+Hwh1xeh
         vBIA==
X-Forwarded-Encrypted: i=1; AJvYcCV3j1DK/m47+d+4e30OGZMMXDRaiv9Yeq1sewFctmUFUWnMIACCW8HuPLHMNRfUCzg9XxgKrtYn@vger.kernel.org, AJvYcCWL7EGEPdql2dkrE4lO/89YT9mut+7lGPP+tlqjYx5qBjHHNPunQOx7Liu161PQlX7EBRydz1VYhBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YvXDGKejFqJD+VLrax8KGBMzv3EkdewA5YTjlzobV+UIof/+
	GYesIu4sK1xrJHQd8hkBtDgbHJbBQNB627eO8VRssVqNW5cPocrt
X-Gm-Gg: ASbGncta2eANGunwz4k2BsYvTtz7+GaZgiIVPDrNZBSEgdBbl8S/U6InswVfb9+nMTl
	E/fVCK/Dc2SQXIhBkLt6IkVBwszxLzRlGFQ4/Gm8HQuidsDO3oU2LlKw0G0BPjtP4MJyOpa7kpf
	xNDyr6GmTDtDvjmmI+PAyyCJAI4phkryoZ4oGub9rXcbLj2cSNY9zDRxgMBf5/dStO8vXUtdohb
	hQz83Y0lz6pEhfmh9qI9pnRmCx47sTlKyzHu1rmqo1Xcrj/Zutr8DfF1N339yWq8e5mqfNHR8zZ
	97Dm78Cdm5QePj0wuxbLtOOEk6mmoXF0CZUhq6rvRhXB
X-Google-Smtp-Source: AGHT+IGgdVD90hk0FDSUojdOdxB8m9vg2HJLxagG+PsuYAPNDkkDYPuZB6uTfoQprAW6abY72qs1qg==
X-Received: by 2002:a05:600c:4f86:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-436685484bamr391770725e9.4.1735835924697;
        Thu, 02 Jan 2025 08:38:44 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8bb4bcsm38687641f8f.111.2025.01.02.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:38:44 -0800 (PST)
Subject: Re: [PATCH v9 18/27] sfc: get endpoint decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-19-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <120839ac-6014-2909-511c-7d9f68e706df@gmail.com>
Date: Thu, 2 Jan 2025 16:38:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241230214445.27602-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 30/12/2024 21:44, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

