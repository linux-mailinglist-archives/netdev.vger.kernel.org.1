Return-Path: <netdev+bounces-116813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C7A94BC71
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17E9B21BE9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436018B47A;
	Thu,  8 Aug 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0RoCiaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B318B46F
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117362; cv=none; b=XjgKT+z9/N+sXsOqlHhiZuoHv8jSjzBayvjRjm6/U+6aa72cQHS8ss/mgfC0CJUaTuTYMP0QkNyYlPz0RyiI+hhrTKBfK0BZjsVucGTKF/tmItthIOTZjoyA1jBVXnl6uwaZXv+bghrge2wBSVnxhkLj04dpIHGykVtwVenqRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117362; c=relaxed/simple;
	bh=On718m8oxGMhzsV2DcfcdIB/URjU5I5tNHidAnicgec=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cIzY5wkuE/AGAwTO+Yt3zd62oefmHzODK4RxkXJQZNAfgIRMuxNdY3Rlwwz9EGh/e8W1k5aJdUS2kF4idrWiwZrCyqvIZXObXp0uh/a5SwnmyL8Y5+Qi1dkRfBqjaY0s79v6XGwzhO7bTt4vpBFLn61is8raBiMtZ6kIlpXIxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0RoCiaJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36ba3b06186so459428f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723117358; x=1723722158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXzWpDPiGfad1hc0xhSQdX2pcoE1NR+vPZtpnGDMy0w=;
        b=c0RoCiaJNFugOktWuih2/xKhB8+dNwWW5KTMR3SFWP/sT846ecq6t1wUWCHmrJGeBo
         kreFsw13GLQgYKq971s0aWhpL9u6FOipwSzUDmiNaLfPp5IOcLdJrKnqcZMgpiyMQfua
         z5G2ILfaVUXSrsRbl3ezdTlenhjPGNW62wU3NUoljDa1ODbVWVxnqTj9ED+LnhfFhvhK
         COdYzuicTS3DWfYoScAL3GUFJ+hiEKTzVmvBgSqVQrhnqzcwH3OUtdEUd7Q5Viy177xz
         NCWhyl1p4n7nrwJ61lFQOiCGcIeolrBCuQxEv/koRmN8429RYdKcJCDsIE13szuxE5r2
         K6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117358; x=1723722158;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXzWpDPiGfad1hc0xhSQdX2pcoE1NR+vPZtpnGDMy0w=;
        b=oJi73Ru4tyP62NYQQiysP/oEUrJK/wu+p36A3h+jR1/oVg7u4RcyQmllxycOzkzhwJ
         Gd6yYcoPiIrGqOPXg6ZQf+wsPk7gOCbIV9i85eGrSyxgaI2bA65qtoluxzo/CaZBvcj1
         +OMdyBmEfHx9+DxBP2e10OGJKLRYD9Inr1Nyqt5gTl//U6GE99auCTVnCRkFUsGxpvoC
         IW1DN2s82jCS+LpGaBZjhTVVF2jdQuDw9J46JmU8KBQOaUrA0y1SQedMxD9rv11SJR7N
         zMu8RLWSBBWiRh+ZCW51YlXQWc7zr7Lj/ikyX3WTIMReQm+Qjpreva1ZZel/cDDM4prL
         fvnQ==
X-Gm-Message-State: AOJu0YwUfg7CF3jWp3rG7VVXayTsp/LTcxm/iy7Xs74KrZWGC7FgwR/B
	tFcJFxoIS7gCN8wf5c5+gkrfBrKJhZ1l05OcXNo17p2bZBalObgl
X-Google-Smtp-Source: AGHT+IGCyNfviCDWuYCiIoi+LM9n0byJubW4a5CxGH3MKE7W4hDdWFItvlERm9/0CMliF0HCxv9T8A==
X-Received: by 2002:adf:fc87:0:b0:366:ef25:de51 with SMTP id ffacd0b85a97d-36d2756de0bmr1292538f8f.49.1723117358260;
        Thu, 08 Aug 2024 04:42:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d271957f8sm1633101f8f.65.2024.08.08.04.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 04:42:37 -0700 (PDT)
Subject: Re: [PATCH net-next v3 12/12] selftests: drv-net: rss_ctx: test
 dumping RSS contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, shuah@kernel.org, przemyslaw.kitszel@intel.com,
 ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
 pavan.chebbi@broadcom.com, petrm@nvidia.com, gal@nvidia.com,
 jdamato@fastly.com, donald.hunter@gmail.com
References: <20240806193317.1491822-1-kuba@kernel.org>
 <20240806193317.1491822-13-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <da2f88b1-9646-8263-7504-ba3938c7a8d8@gmail.com>
Date: Thu, 8 Aug 2024 12:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806193317.1491822-13-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 06/08/2024 20:33, Jakub Kicinski wrote:
> Add a test for dumping RSS contexts. Make sure indir table
> and key are sane when contexts are created with various
> combination of inputs. Test the dump filtering by ifname
> and start-context.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

