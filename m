Return-Path: <netdev+bounces-79137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459AA877F39
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 12:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D983E1F21C1E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1C3A268;
	Mon, 11 Mar 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzvxGsX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953C3B78E
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157485; cv=none; b=G3jvLtJNwACF6nzLbH1X5c3mTYv6l04I4/F99fKqlmqilDDaeIwwBTjwXYgw3Euw/U2aaPXXE+JtYRt7Ij0QRn+OeNbSPG/VHDbbm6aykO1LUlV/dNC37xg0lttDU3F31KfsEIHvauojq5d9lmjtTTzgzEh2atQav4SnKucvZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157485; c=relaxed/simple;
	bh=AKd86koyfwBfcumKpDfpr+YVSyvnmxZPDPbes8DXjCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWJgCNVrPMF4f/i+ZrjQyd7R3V/6AVjTKsHKUIxNGEyrue6gCwQekGMI47JrIFM7n+4EYT5AWoa/Xt/sOCB8cl4zPU5xpkKOgfgdUp/xwxsoJlRrZ0Wlpkurdj7GTLTImeM37ENAMHWuJw8zq6b1tfm5+RPAm17ks8cF6Kv1Tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzvxGsX1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e64997a934so3260323b3a.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710157483; x=1710762283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6T0UNjqr8f4BqOYV/Wf+JZvk2j4FjJ+sWuTiIamEBZg=;
        b=OzvxGsX1BQ8ngQTYABuYIDQDjsAZRXsYicHcDWJtG/k5g2IJK6BLSHZJb80xCbV0Fn
         fSl5dBzrVSm3s1zeEeq+SlwU1u7UMPFjrbvB04FGMoM3qk3DuhM45D1oMcJF/fduxD8w
         T5Hk7Dhp2vsh4mxb/46rE5nQMrfDqrLoRnlcP2i+toIl8PaADod/aKQs2T15VO4OgH3m
         gAja97bgqSBCt+jD68ok4Nh3oAp/hqpI7BL3HnffY0bv+jDl4aKu94qvrTpIwDeLcwq6
         tjJugop8zsVjvABac8cfDMjOGi0cv9OcI4pa24uJHB3EpNYx/OAiIlv25KeFibEJj6ih
         sCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710157483; x=1710762283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T0UNjqr8f4BqOYV/Wf+JZvk2j4FjJ+sWuTiIamEBZg=;
        b=tq2y6d6wd6CmlYYCubeHRi9C59wIYx79Q8wGEsUaoVUCLVOcIPH3aYFE4zbU346I7e
         QFpgemTOFl2FbvGUT+JepOramZV1TN7p4Nzbje/o9VYBAB8narFO8VuH3vdsNpgqzc14
         SSDGHVvySgoWv4M/dIlYI4jhlg1KldHYNRkthJXUxkyjH4WI+vDIdpw1P6wxj31Dzatw
         6TRFBOPquYFUCZ7uEehH/BP3n1mudNGU9doCPmbSdRgCdELSiHaFsiJbrRrlKMPbFK/H
         n/oMezB/5eBO1vF3gcGdH650ShM8SmFSxMPZzEuKTO4sAXdKMz9xM89O8wok87wxuJJE
         JLUA==
X-Gm-Message-State: AOJu0YxeZcGwCPAbm8OLhNvQtDwI5VGQyA6x6L6DZ4TdbJ3E7oI8znCe
	RZkXH9WtVXVL6EcLfcG1BAxyztK6qUjUmZWbFZXJ6O/XJmN/UYTI
X-Google-Smtp-Source: AGHT+IFhZ03vXc/CLpPN25M3t1Lanu4UfYz+2sNOwU8Lxl70c9Z3MCWxmLyxBfJOOXZJTmab4kC6qw==
X-Received: by 2002:a05:6a20:8f21:b0:1a1:3812:aa2d with SMTP id b33-20020a056a208f2100b001a13812aa2dmr169783pzk.9.1710157483474;
        Mon, 11 Mar 2024 04:44:43 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b001dd652ef8d6sm4623543pln.152.2024.03.11.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:44:43 -0700 (PDT)
Date: Mon, 11 Mar 2024 19:44:39 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: Re: bonding: Do we need netlink events for LACP status?
Message-ID: <Ze7up2WpWa3Yv5Ap@Laptop-X1>
References: <ZeaSkudOInw5rjbj@Laptop-X1>
 <32499.1709620407@famine>
 <Zefg0-ovyt5KV8WD@Laptop-X1>
 <15143.1710040289@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15143.1710040289@famine>

On Sat, Mar 09, 2024 at 07:11:29PM -0800, Jay Vosburgh wrote:
> 	Generally speaking, I don't see an issue with adding these type
> of netlink events, as in normal usage the volume will be low.
> 
> 	Looking at the code, I think it would be a matter of adding the
> new IFLA_BOND_LACP_STUFF labels, updating bond_fill_slave_info() and
> maybe bond_fill_info() to populate the netlink message for those new
> IFLAs.  Add a call to call_netdevice_notifiers() in ad_mux_machine()
> when the state changes, using a new event type that would need to be
> handled by rtnetlink_event().

Thank Jay, I will add this on my todo list.

Hangbin

