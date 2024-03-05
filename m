Return-Path: <netdev+bounces-77388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88182871846
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18720B21196
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCA2AF04;
	Tue,  5 Mar 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JcrZlHlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908B1EEFD
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627720; cv=none; b=SswxzNWakY4SrI6uSSJAJGxpqYH2/0dzTN99lrJtzUza2nKARknUUt6TESCBNEphT7iaOGkKrESxdu2AzIgM5zRMoAip4kdrqqGvvIhmt+IedeMovB16lzWhkNfbO0Y0typQ5z/uMYqZzOg7bUuz3qiCqaqES5QdvKLXKdf6kvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627720; c=relaxed/simple;
	bh=82vsJjoVoWmADD8rvpl3Qp5VtIdC1v3LD9anMkdwnio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ptH0ZqkmaS4kyyQ7bVKMQWeSJRvsDp7hVtZ2DSt037vdXvPactO/7E4IKfoPzVHMFz/c0DUXpjJGjyagpxGU4zvEziOS+P7j/yekq5SHu5h8ChE31zATMLSNwAigF2R6pdEw0BV3qIDJH3IHPa0rRHP8aShdVtdy/0NN3eOVUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JcrZlHlb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so1063429a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 00:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709627717; x=1710232517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PALRyszw+AlcpDZUROc9AgnCBJMpueCSeAJq71aQVJ8=;
        b=JcrZlHlbBLWyDeejHHJws4S/uQJyPjUy61ll/9bQ93TjkBCJ/6jF4U5dT9AcYauxME
         5Wim+A2q8J2yLP2vMzJTwuSuVNYZFdTz5UVvKpgsylGYZQL6oz11cQGrU7Af7EXwv/K7
         uXvkhFTmeD+hAXuhtB9An5KGdJPwhGq3d4dMXuGF9lh9cGdpndAy4YXkr7sRRV3CCqy6
         88Z6/hJZ0h0jucrdASJ/td4hyJKDDrLb+0EmdHNrcjHZqQqf1twvbTn5TyqNHrBja9/w
         bQMLyiSV4wFv+g+leHUvKyHGo5tfRYQ+Uoyn7zDKv87jVYwqxj0Yy5yzOggpHheek4Wi
         m3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627717; x=1710232517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PALRyszw+AlcpDZUROc9AgnCBJMpueCSeAJq71aQVJ8=;
        b=cjxZFiLgDLeHiU3D00QuPRH3xSbDQajk8dYa0F5LDQyoV5jAsFIrlrcDYKAirPEpZF
         P11OAG8S8InL6RiF/KTqaB2zgUODHyA7mmVlJgkuAt5c1WzQIw+oqztq52bnMZ1HqvXd
         FQrpaxnte45ra02LqNW2mh8j4B5yLrkP8tmlRaKzI8yEm6Y1RqhZjbxOj22ozXykrrbP
         yph6T1hQCwWTeUIAV5XFC2MbmEuyb2CNg1qEIYhMvUtEo4UY2KJsKYgttsQtDh9btOiZ
         Dpgas9ysfR40oLBFeHVNThKdjJUuBGkjdvpAvlmhyRqiCrWMgRhC6BzxMjWGDkzb51R6
         7j8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXfXKEM15adIJ1oi4cAXNeHEercNWjtEN+JQ/BGC3ry9a3O3UX4lCgBECNsze7HjjvNJUsmS+udHE+glJjPzm/vqNpBKXB
X-Gm-Message-State: AOJu0Yx+3RdwGa46dOqti2ZftK9q6utUHYh1Jc+U0JfgbN3vaJnDNPMj
	OPHIAan/6kopxc79UctW3HDuy5rBfgTs3lhZ0/9VQD2rO+ciTRdObfl6lpfJNyg=
X-Google-Smtp-Source: AGHT+IER8p93l0Uf/lQDwhGDEJk0Kqf+52LrfzFTfrA8CPi3Xno+ht4XI/iYhAltyL13LNun8owbZw==
X-Received: by 2002:a17:906:d287:b0:a3f:50f0:7a0a with SMTP id ay7-20020a170906d28700b00a3f50f07a0amr2054787ejb.20.1709627716925;
        Tue, 05 Mar 2024 00:35:16 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906355500b00a44dfaf84f4sm3524870eja.153.2024.03.05.00.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:35:16 -0800 (PST)
Message-ID: <a280d52a-c619-4e67-bda3-99e211b6d036@suse.com>
Date: Tue, 5 Mar 2024 09:35:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sr9800: Add check for usbnet_get_endpoints
To: Chen Ni <nichen@iscas.ac.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com, andrew@lunn.ch,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240305075927.261284-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240305075927.261284-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 08:59, Chen Ni wrote:
> Add check for usbnet_get_endpoints() and return the error if it fails
> in order to transfer the error.

Hi,

thank you for the patch. The asix driver also fails
to check for that failure. Could you make a similar patch?

	Regards
		Oliver


