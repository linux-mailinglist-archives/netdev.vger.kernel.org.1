Return-Path: <netdev+bounces-228721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F7BD320F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9CE189D3F2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C718261B9C;
	Mon, 13 Oct 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvMRcuBA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1512270553
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360634; cv=none; b=red+Vof+D/Wac5+Vw3gOyXhAldWx1yJtUvmMHUMdJ8hoo6OXL2kWWhDGLs2lG91wBWlf3cC2QjZBCP0Ur7d6PbulF1CFbG38ilLqEGusfrrSjcIk7/3TJhzMwweRB1tg34DSJk+hYKUDy2q5/cy9SnINJPF2OKm15NaILLkC1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360634; c=relaxed/simple;
	bh=BhGgZeUzeRZQ9pAArolPZbMYxYATxpinZiOd/YND5Iw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZvvU5lcznLuKlDHg1TLLXcJ+KZcrJ+iUCnE1hsu5Uf/beLq99Ydq2sM24H+9ChT7J3+Njipwip76Oes0oYjtr3LMqGHByoR8xRDQVxd2Y5fJjgKyhyhoyPAw7YFE5QLujgBYiukKrGD76Fx4trmUIzi/5wdIzcgYJFAbayk1vkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvMRcuBA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760360631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BhGgZeUzeRZQ9pAArolPZbMYxYATxpinZiOd/YND5Iw=;
	b=gvMRcuBAUCZz6CyU7K76HeUazoGbCUC3O9i6hib2MxwmMeEL6k771Rf3U2utU+tH84pstw
	6ZWF3NJIMYnPxuVM5EghC4NyaQouPKjxBZZkqCmGAFCp9WNjOyHm0qclzy1tDA08pZlvw8
	2TSAe/FYD/UpOndOs0E8ug8aRtJJGl0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-aiN5jZiaMAycddjwOvDkiA-1; Mon, 13 Oct 2025 09:03:50 -0400
X-MC-Unique: aiN5jZiaMAycddjwOvDkiA-1
X-Mimecast-MFC-AGG-ID: aiN5jZiaMAycddjwOvDkiA_1760360629
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso3354284f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 06:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360629; x=1760965429;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhGgZeUzeRZQ9pAArolPZbMYxYATxpinZiOd/YND5Iw=;
        b=qRtOqm5CnQ2UodvjYtLHFzyukkpXqoDV+pRS3PxaUR0oAZ6cvpaYjT5IXngnPQC9Vi
         vCl+TE1/oArYp+c+hZ1wSh1xCmsG1CdIHDbOyOj3HeRdZstOKPHbNH2J3ELjFKUsv6Vn
         JUcSE5I4WyyIAV1jJ0zdVOGmyV2BGUhIKFjY0jEkBD7YTNTiJmKupFkgTeNOva7e+FDW
         ELx4Z4yWRTbMAnBwEQgRrRUtsO9L1tCld/SxHvtYlnZKQfBWpIfLvxsRxawqidPywR5/
         JwAlJ+IDJV3bZuexlVmGWiU+urdqAI8Cs7tDwfFNWJ8GwwSVvq6r/W+o+DWchxn2Dxjr
         FioQ==
X-Gm-Message-State: AOJu0YwBf380ov/QsecIbTEjhu3WP76SRTiYYzbFaTNDAdMdIOdoKJpK
	Cr2Rl4faHmNS+EwT7K+7R/1eT0Fm+or6PNrzgTwPqN6kFMb2g/A+CtIMKl2cH+zf8kdp7SxJOZC
	I/HoDJYTnRM9hG3rHF8fDjG1tSI576sCxuqXTPw/tUJDZFAZr967JfSnw3Cu/DrFESvoBQE46bX
	TUs/KgtmDesvyjxPMswjUYeHlpRo+bSjxNF5ML6X0=
X-Gm-Gg: ASbGncv1XK2o8frgPdy2qYXki/Xt8jYVYp19Im+oomb9P90OLMAfqFWcnLZ3zPTxbKM
	9KO+95NIr2T0V0bVNvWT2bvLcljcEmVCwl8ul5Sf2pUZJ6QxVFuaagQsg3zBDhts6pM7nqJo/Gh
	sXOvwwWQIcI3Fu9u05l804f2S8Z4pe2sGm/WfMg/3vHeKZcz/z6zHrNv8rkA6WPvXC6nGrR57tF
	e56aIyJrrpuOWJWfsoFf2ti4eMPhLD/Jia/3RKs54zvLL4Xp0NJIwZ7bYV+X0ISCTr/iFfUls/O
	phy7qcII2O/bFRT3MfWhrlkc6EXGfgAs0sUXyJifv+98
X-Received: by 2002:a05:6000:2f83:b0:401:e7a8:5c8d with SMTP id ffacd0b85a97d-42666ac463emr10548780f8f.6.1760360628787;
        Mon, 13 Oct 2025 06:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtHrN7uKfrCCpaV/eGs1OcnKcfCLXCEEwug5qbhKOFD0JLyHkSDfhs9B+s5fCdYEz1zLpQ3g==
X-Received: by 2002:a05:6000:2f83:b0:401:e7a8:5c8d with SMTP id ffacd0b85a97d-42666ac463emr10548756f8f.6.1760360628305;
        Mon, 13 Oct 2025 06:03:48 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e6c0fab7sm2798306f8f.43.2025.10.13.06.03.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:03:47 -0700 (PDT)
Message-ID: <01d6cb95-cb91-4de0-be8a-faabeaa0dfe8@redhat.com>
Date: Mon, 13 Oct 2025 15:03:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] net-next is OPEN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open again, gathering 6.19 work.

/P


