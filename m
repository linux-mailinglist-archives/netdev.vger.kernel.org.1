Return-Path: <netdev+bounces-74067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81DE85FCEA
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B831C21FFD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3614F9E4;
	Thu, 22 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="bliWjxXJ"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E61419A4
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616758; cv=none; b=dQNRkKVr1AqX4XEIC3kCE2hFWS9Z0CpGE+oxF32/NsixjyVNNSTVVBMwhgVCIkxSuzWDvMlvgmLyMRagZAeUVMfRuH8xhF7UxW4OjKbyzVGLEgmkrzXu9seK9NMwjL17H3QF1+2oCGT8ruwkYPC1DAhz1/Nc/h+zOwTg3NaLc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616758; c=relaxed/simple;
	bh=/0Tamd0+gHWdt8BbXNle4HgEpVGnAlxwJYHhZNtfVa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PMo+IPqBUCJ18AJqSUnppw/KHpPt5qqadDDGHQOY0MsT7Ri+9g6deAoz0HmwtYrPp3u/LIoqOHzSETaYOvAL316YbwHzrd9NRLI5WQ/XtA0WakFjm8OWtWcJKNpbPHbPOJGghfwB4+ZNMnfhC24OnmFziaAg2x/g5Gh4IDGRyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=bliWjxXJ; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 91CD3200E2A0;
	Thu, 22 Feb 2024 16:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 91CD3200E2A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708616754;
	bh=odXtPP1AxnA7kUY3nEQ6pHnhu9NMJ8JAvYSstxzj3dc=;
	h=From:To:Cc:Subject:Date:From;
	b=bliWjxXJGSbKE3QcFV1eUk+i7y3Vvbq2tGOMd4tpf2mPqw0gCdOkv/GOZs6lOGr1h
	 s4ldX/Kg0ncjHSoUM7F0/ALX7RdU7EU0gL9JZ6GIG07sLzcl9qtQhaCVas1wjToZT8
	 r/r2CFWJgyPsVhIgAnDj9Kl5V4AR7oXM5YTQt/yRF0oeNPdKufpKWb2a7SmkdC9Ddc
	 xLiNsysK7QHKdxaVYxMMCBpOK1wQ+BFGgjR5N9XWhhAsmuH0EyKUCHzO1qgZslvk7m
	 spVC8p7dGBvpB7fhrF+wR9WUHXo2A+SN285T+/kdXrgc17DXCYtkdNEc4t390gGuXk
	 3v1cMGA633odg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 0/3] multicast event support for ioam6
Date: Thu, 22 Feb 2024 16:45:36 +0100
Message-Id: <20240222154539.19904-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ioam multicast events via a new command: ip ioam
monitor.

Justin Iurman (3):
  uapi: ioam6: update uapi based on net-next
  ip: ioam6: add monitor command
  man8: ioam: add doc for monitor command

 include/uapi/linux/ioam6_genl.h | 20 +++++++++
 ip/ipioam6.c                    | 78 ++++++++++++++++++++++++++++++++-
 man/man8/ip-ioam.8              |  5 +++
 3 files changed, 102 insertions(+), 1 deletion(-)


base-commit: d2f1c3c9a8a38493cdec9fb93534ccec76c48fe2
-- 
2.34.1


